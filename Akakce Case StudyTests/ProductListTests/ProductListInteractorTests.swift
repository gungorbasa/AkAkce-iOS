//
//  ProductListInteractorTests.swift
//  Akakce Case StudyTests
//
//  Created by Gungor Basa on 8/4/24.
//

import XCTest
@testable import Akakce_Case_Study

final class ProductListInteractorTests: XCTestCase {
    private let expectedProducts = [
        Product(
            id: 1,
            title: "1",
            price: 11.11,
            description: "1D",
            category: .electronics,
            image: "img1",
            rating: Rating(rate: 4.7, count: 123),
            amountLeft: 123
        ),
        Product(
            id: 2,
            title: "2",
            price: 22.22,
            description: "2D",
            category: .jewelery,
            image: "img2",
            rating: Rating(rate: 4.8, count: 125),
            amountLeft: 125
        ),
    ]
    
    private let productNetworkModels = [
        ProductNetworkModel(
            id: 1,
            title: "1",
            price: 11.11,
            description: "1D",
            category: "electronics",
            image: "img1",
            rating: .init(rate: 4.7, count: 123)
        ),
        ProductNetworkModel(
            id: 2,
            title: "2",
            price: 22.22,
            description: "2D",
            category: "jewelery",
            image: "img2",
            rating: .init(rate: 4.8, count: 125)
        )
    ]
    
    func test_fetch_products() async throws {
        let serviceMock = ProductListServiceMock(products: productNetworkModels, horizontalProducts: [])
        let productModelFactoryMock = ProductModelFactoryMock(product: expectedProducts.first!, products: expectedProducts)
        let interactor = ProductListInteractorImp(service: serviceMock, productModelFactory: productModelFactoryMock)
        
        let products = try await interactor.fetchProducts()
        
        XCTAssertEqual(products, expectedProducts)
    }
    
    func test_fetch_horizontal_products() async throws {
        let serviceMock = ProductListServiceMock(products: [], horizontalProducts: productNetworkModels)
        let productModelFactoryMock = ProductModelFactoryMock(product: expectedProducts.first!, products: expectedProducts)
        let interactor = ProductListInteractorImp(service: serviceMock, productModelFactory: productModelFactoryMock)
        
        let products = try await interactor.fetchProducts()
        
        XCTAssertEqual(products, expectedProducts)
    }
}
