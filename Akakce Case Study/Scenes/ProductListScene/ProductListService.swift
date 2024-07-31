//
//  ProductListService.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 7/31/24.
//

import Foundation
import Networking

protocol ProductListService {
    func fetchProducts() async throws -> [ProductNetworkModel]
    func fetchHorizontalProducts() async throws -> [ProductNetworkModel]
}

final class ProductListServiceImp: ProductListService {
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func fetchProducts() async throws -> [ProductNetworkModel] {
        try await network.run(ProductRoutes.product)
    }
    
    func fetchHorizontalProducts() async throws -> [ProductNetworkModel] {
        try await network.run(ProductRoutes.horizontalProduct)
    }
}
