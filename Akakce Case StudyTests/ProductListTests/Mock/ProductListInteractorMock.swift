//
//  ProductListInteractorMock.swift
//  Akakce Case StudyTests
//
//  Created by Gungor Basa on 8/5/24.
//

import XCTest
@testable import Akakce_Case_Study

final class ProductListInteractorMock: ProductListInteractor {
    private let products: [Product]
    private let horizontalProducts: [Product]
    
    init(products: [Product], horizontalProducts: [Product]) {
        self.products = products
        self.horizontalProducts = horizontalProducts
    }
    
    func fetchProducts() async throws -> [Product] {
        return products
    }
    
    func fetchHorizontalProducts() async throws -> [Product] {
        return horizontalProducts
    }
}
