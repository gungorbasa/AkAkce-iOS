//
//  ProductListViewController.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 7/31/24.
//

import UIKit

enum ProductListViewAction: Equatable, Sendable {
    case horizontalProducts([ProductListHeaderCell.State])
    case products([ProductListCollectionViewCell.State])
}

@MainActor
protocol ProductListView: AnyObject {
    func apply(action: ProductListViewAction)
}

final class ProductListViewController: UIViewController, ProductListView {
    private var presenter: ProductListPresenter
    
    private let stackView = UIStackView.autolayoutView(axis: .vertical)
    private let horizontalPagerView = ProductListPagerView.autolayoutView()
    private let productListCollectionView = ProductListCollectionView.autolayoutView()
    
    init(presenter: ProductListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.onViewDidLoad()
    }
    
    func apply(action: ProductListViewAction) {
        switch action {
        case .horizontalProducts(let items):
            horizontalPagerView.apply(items: items)
        case .products(let items):
            productListCollectionView.apply(items: items)
        }
    }
}

private extension ProductListViewController {
    func setup() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(horizontalPagerView)
        stackView.addArrangedSubview(productListCollectionView)
        
        productListCollectionView.onTapItem = { [weak self] state in
            guard let self else { return }
            self.presenter.onTapProductCollectionViewCell(item: state)
        }
        
        horizontalPagerView.onTapItem = { [weak self] state in
            guard let self else { return }
            self.presenter.onTapProductListHeaderCell(item: state)
        }
        
        stackView.spacing = 16
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            horizontalPagerView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
