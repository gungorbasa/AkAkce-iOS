//
//  ProductDetailsViewController.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import UIKit

enum ProductDetailsViewAction: Equatable, Sendable {
    case productDetail(ProductView.State)
}

@MainActor
protocol ProductDetailsView: AnyObject {
    func apply(action: ProductDetailsViewAction)
}

final class ProductDetailsViewController: UIViewController, ProductDetailsView {
    private let presenter: ProductDetailsPresenter
    private let productView = ProductView.autolayoutView()
    
    init(presenter: ProductDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(productView)
        
        NSLayoutConstraint.activate(
            [
                productView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                productView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                productView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                productView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16)
            ]
        )
        
        presenter.onViewDidLoad()
        view.backgroundColor = .white
    }
    
    func apply(action: ProductDetailsViewAction) {
        switch action {
        case .productDetail(let state):
            productView.configure(with: state)
        }
    }
}
