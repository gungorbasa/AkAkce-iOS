//
//  ProductDetailsPresenter.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import Foundation

protocol ProductDetailsPresenter {
    @MainActor
    func onViewDidLoad()
}

final class ProductDetailsPresenterImp: ProductDetailsPresenter {
    private let interactor: ProductDetailsInteractor
    private let productId: Int
    
    weak var view: ProductDetailsView?
    
    init(interactor: ProductDetailsInteractor, productId: Int) {
        self.interactor = interactor
        self.productId = productId
    }
    
    func onViewDidLoad() {
        Task {
            let product = try await interactor.fetchProductDetails(by: productId)
            view?.apply(
                action: .productDetail(
                    ProductView.State(
                        title: product.title,
                        description: product.description,
                        image: product.image,
                        amountLeft: product.amountLeft,
                        price: product.price,
                        rating: product.rating.rate
                    )
                )
            )
            print(product)
        }
    }
}
