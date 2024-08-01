//
//  ProductListPagerView.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import UIKit
import Combine

final class ProductListPagerView: UIView {
    typealias Datasource = UICollectionViewDiffableDataSource<Int, ProductListHeaderCell.State>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, ProductListHeaderCell.State>
    
    private let stackView = UIStackView.autolayoutView()
    private var pagerView = PageControlFooterView.autolayoutView()
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeCollectionViewLayout()
    ).autolayoutView()
    
    private var dataSource: Datasource?
    private let pagingInfoSubject = PassthroughSubject<PageControlFooterView.PagingInfo, Never>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(items: [ProductListHeaderCell.State]) {
        addPagerFooterView(with: items.count)
        
        var snapshot = Snapshot()
        
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

private extension ProductListPagerView {
    func setup() {
        setupStackView()
        setupCollectionView()
    }
    
    func setupStackView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        )
    }
    
    func setupCollectionView() {
        stackView.addArrangedSubview(collectionView)
        collectionView.register(cellType: ProductListHeaderCell.self)
        dataSource = makeDataSource()
    }
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(150)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(150)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = makeSection(from: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func makeSection(from group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.visibleItemsInvalidationHandler = { [weak self] _, offset, _ in
            guard let self = self else { return }
            let page = round(offset.x / max(self.bounds.width, 1.0))
            
            self.pagingInfoSubject.send(PageControlFooterView.PagingInfo(currentPage: Int(page)))
        }
        
        return section
    }
    
    func makeDataSource() -> Datasource {
        let dataSource = Datasource(collectionView: collectionView, cellProvider: { collectionView, indexPath, state in
            guard let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ProductListHeaderCell.self) else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: state)
            return cell
        })
        
        return dataSource
    }
    
    func makeFooterView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
    }
    
    func addPagerFooterView(with itemCount: Int) {
        pagerView.removeFromSuperview()
        
        let footer = PageControlFooterView.autolayoutView()
        stackView.addArrangedSubview(footer)
        let heightAnchor = footer.heightAnchor.constraint(equalToConstant: 20)
        heightAnchor.priority = .defaultHigh
        heightAnchor.isActive = true
        
        footer.configure(with: itemCount)
        footer.subscribeTo(subject: pagingInfoSubject)
        
        pagerView = footer
    }
}
