//
//  ProductListViewController.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 7/31/24.
//

import UIKit

enum ProductListViewAction: Equatable, Sendable {
    case horizontalProducts([ProductListHeaderCell.State])
    case products
}

@MainActor
protocol ProductListView: AnyObject {
    func apply(action: ProductListViewAction)
}

final class ProductListViewController: UIViewController, ProductListView {
    private var presenter: ProductListPresenter
    
    private let horizontalPagerView = ProductListPagerView.autolayoutView()
    
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
        case .products:
            break
        }
    }
}

private extension ProductListViewController {
    func setup() {
        setupHorizontalPagerView()
    }
    
    func setupHorizontalPagerView() {
        view.addSubview(horizontalPagerView)
        
        NSLayoutConstraint.activate([
            horizontalPagerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            horizontalPagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalPagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            horizontalPagerView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
