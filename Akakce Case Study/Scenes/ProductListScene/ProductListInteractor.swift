//
//  ProductListInteractor.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 7/31/24.
//

import Foundation
import Networking

protocol ProductListInteractor: Sendable {
    func fetchProducts() async throws -> [Product]
    func fetchHorizontalProducts() async throws -> [Product]
}

final class ProductListInteractorImp: ProductListInteractor {
    private let service: ProductListService
    private let productModelFactory: ProductModelFactory
    
    init(
        service: ProductListService,
        productModelFactory: ProductModelFactory = ProductModelFactoryImp()
    ) {
        self.service = service
        self.productModelFactory = productModelFactory
    }
    
    func fetchProducts() async throws -> [Product] {
        let products = try await service.fetchProducts()
        return productModelFactory.make(from: products)
    }
    
    func fetchHorizontalProducts() async throws -> [Product] {
        let products = try await service.fetchHorizontalProducts()
        return productModelFactory.make(from: products)
    }
}
