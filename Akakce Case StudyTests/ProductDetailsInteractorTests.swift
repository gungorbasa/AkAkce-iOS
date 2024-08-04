//
//  ProductDetailsInteractorTests.swift
//  Akakce Case StudyTests
//
//  Created by Gungor Basa on 8/4/24.
//

import XCTest
@testable import Akakce_Case_Study

final class ProductDetailsInteractorTests: XCTestCase {
    let products: [ProductNetworkModel] = [
        .init(
            id: 1,
            title: "1",
            price: 11.11,
            description: "Description1",
            category: "fashion",
            image: "image.com",
            rating: .init(rate: 4.5, count: 123)
        ),
        .init(
            id: 2,
            title: "2",
            price: 12.11,
            description: "Description2",
            category: "fashionista",
            image: "image.com",
            rating: .init(rate: 4.7, count: 123)
        ),
        .init(
            id: 3,
            title: "3",
            price: 11.31,
            description: "Description3",
            category: "fashion",
            image: "image.com3",
            rating: .init(rate: 3.5, count: 323)
        )
    ]
    
    let horizontalProducts: [ProductNetworkModel] = [
        .init(
            id: 2,
            title: "2",
            price: 12.11,
            description: "Description2",
            category: "fashionista",
            image: "image.com",
            rating: .init(rate: 4.7, count: 123)
        ),
        .init(
            id: 3,
            title: "3",
            price: 11.31,
            description: "Description3",
            category: "fashion",
            image: "image.com3",
            rating: .init(rate: 3.5, count: 323)
        )
    ]
    
    func makeInteractor() -> ProductListInteractor {
        let service = ProductListServiceMock(products: products, horizontalProducts: horizontalProducts)
        return ProductListInteractorImp(service: service)
    }
    
    func test_number_of_products_returned() async throws {
        let interactor = makeInteractor()
        let domainProducts = try await interactor.fetchProducts()
        let horizontalDomainProducts = try await interactor.fetchHorizontalProducts()
        
        XCTAssertTrue(domainProducts.count == products.count)
        XCTAssertTrue(horizontalDomainProducts.count == horizontalProducts.count)
    }
    
//    func test_products_properly_returns
}
