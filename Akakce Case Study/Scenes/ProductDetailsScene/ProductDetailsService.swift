//
//  ProductDetailsService.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import Foundation
import Networking

protocol ProductDetailsService: Actor {
    func fetchProductDetails(by id: Int) async throws -> ProductNetworkModel
}

actor ProductDetailsServiceImp: ProductDetailsService {
    private let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func fetchProductDetails(by id: Int) async throws -> ProductNetworkModel {
        try await networking.run(ProductRoutes.productDetails(id: "\(id)"))
    }
}
