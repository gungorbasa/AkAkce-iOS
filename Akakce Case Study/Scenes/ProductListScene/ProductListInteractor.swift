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
    
    init(service: ProductListService) {
        self.service = service
    }
    
    func fetchProducts() async throws -> [Product] {
        let products = try await service.fetchProducts()
        return products.map { makeProduct(from: $0) }
    }
    
    func fetchHorizontalProducts() async throws -> [Product] {
        let products = try await service.fetchHorizontalProducts()
        return products.map { makeProduct(from: $0) }
    }
    
    private func makeProduct(from networkModel: ProductNetworkModel) -> Product {
        Product(
            id: networkModel.id,
            title: networkModel.title,
            price: networkModel.price,
            description: networkModel.description,
            category: Category(rawValue: networkModel.category),
            image: networkModel.image,
            rating: Rating(rate: networkModel.rating.rate, count: networkModel.rating.count), 
            amountLeft: networkModel.rating.count
        )
    }
}
