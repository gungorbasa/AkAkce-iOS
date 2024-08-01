//
//  ProductDetailsInteractor.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import Foundation

protocol ProductDetailsInteractor: Actor {
    func fetchProductDetails(by id: Int) async throws -> Product
}

actor ProductDetailsInteractorImp: ProductDetailsInteractor {
    private let service: ProductDetailsService
    
    init(service: ProductDetailsService) {
        self.service = service
    }
    
    func fetchProductDetails(by id: Int) async throws -> Product {
        let networkProduct = try await service.fetchProductDetails(by: id)
        return Product(
            id: networkProduct.id,
            title: networkProduct.title,
            price: networkProduct.price,
            description: networkProduct.description,
            category: Category(rawValue: networkProduct.category),
            image: networkProduct.image,
            rating: .init(rate: networkProduct.rating.rate, count: networkProduct.rating.count),
            amountLeft: networkProduct.rating.count
        )
    }
}
