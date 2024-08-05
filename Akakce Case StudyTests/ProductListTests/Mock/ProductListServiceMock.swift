//
//  ProductListServiceMock.swift
//  Akakce Case StudyTests
//
//  Created by Gungor Basa on 8/4/24.
//

import Foundation
@testable import Akakce_Case_Study

struct ProductListServiceMock: ProductListService {
    let products: [ProductNetworkModel]
    let horizontalProducts: [ProductNetworkModel]
    
    func fetchProducts() async throws -> [ProductNetworkModel] {
        return products
    }
    
    func fetchHorizontalProducts() async throws -> [ProductNetworkModel] {
        return horizontalProducts
    }
}
