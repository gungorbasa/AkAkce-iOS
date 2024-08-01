//
//  ProductListCollectionView.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import UIKit

final class ProductListCollectionView: UIView {
    typealias Datasource = UICollectionViewDiffableDataSource<Int, ProductListCollectionViewCell.State>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, ProductListCollectionViewCell.State>
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeCollectionViewLayout()
    ).autolayoutView()
    
    private var dataSource: Datasource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func apply(items: [ProductListCollectionViewCell.State]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

private extension ProductListCollectionView {
    func setup() {
        addSubview(collectionView)
        collectionView.register(cellType: ProductListCollectionViewCell.self)
        dataSource = makeDataSource()
        
        NSLayoutConstraint.activate(
            [
                collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            ]
        )
    }
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(240)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none

        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }


    func makeDataSource() -> Datasource {
        let dataSource = Datasource(collectionView: collectionView, cellProvider: { collectionView, indexPath, state in
            guard let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ProductListCollectionViewCell.self) else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: state)
            return cell
        })
        
        return dataSource
    }
}
