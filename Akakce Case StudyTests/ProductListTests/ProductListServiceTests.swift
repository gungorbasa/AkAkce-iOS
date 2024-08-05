//
//  ProductDetailsServiceTests.swift
//  Akakce Case StudyTests
//
//  Created by Gungor Basa on 8/4/24.
//

import XCTest
@testable import Akakce_Case_Study

final class ProductListServiceTests: XCTestCase {
    private let expectedProducts = [
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
        let networkingMock = NetworkingMock(expectedResult: expectedProducts)
        let service = ProductListServiceImp(network: networkingMock)
        
        let products = try await service.fetchProducts()
        
        XCTAssertEqual(products, expectedProducts)
        let calledPaths = await networkingMock.calledEndpoints.map(\.path)
        let expectedPaths = [ProductEndpoints.product.path]
        XCTAssertEqual(calledPaths, expectedPaths)
    }
    
    func test_fetch_horizontal_products() async throws {
        let networkingMock = NetworkingMock(expectedResult: expectedProducts)
        let service = ProductListServiceImp(network: networkingMock)
        
        let horizontalProducts = try await service.fetchHorizontalProducts()
        
        XCTAssertEqual(horizontalProducts, expectedProducts)
        let calledPaths = await networkingMock.calledEndpoints.map(\.path)
        let expectedPaths = [ProductEndpoints.product.path]
        XCTAssertEqual(calledPaths, expectedPaths)
    }
    
    func test_fetch_products_throws_error() async throws {
        struct TestError: Error {}
        let networkingMock = NetworkingMock(expectedError: TestError())
        let service = ProductListServiceImp(network: networkingMock)
        
        do {
            _ = try await service.fetchProducts()
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertTrue(error is TestError)
        }
    }
    
    func test_fetch_horizontal_products_throws_error() async throws {
        struct TestError: Error {}
        let networkingMock = NetworkingMock(expectedError: TestError())
        let service = ProductListServiceImp(network: networkingMock)
        
        do {
            _ = try await service.fetchHorizontalProducts()
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertTrue(error is TestError)
        }
    }
}
