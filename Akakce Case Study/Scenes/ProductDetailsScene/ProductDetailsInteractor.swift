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
    private let productModelFactory: ProductModelFactory
    
    init(
        service: ProductDetailsService,
        productModelFactory: ProductModelFactory = ProductModelFactoryImp()
    ) {
        self.service = service
        self.productModelFactory = productModelFactory
    }
    
    func fetchProductDetails(by id: Int) async throws -> Product {
        let networkProduct = try await service.fetchProductDetails(by: id)
        return productModelFactory.make(from: networkProduct)
    }
}
