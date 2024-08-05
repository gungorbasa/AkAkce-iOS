//
//  ProductModelFactoryTest.swift
//  Akakce Case StudyTests
//
//  Created by Gungor Basa on 8/4/24.
//

import XCTest
@testable import Akakce_Case_Study

final class ProductModelFactoryTests: XCTestCase {
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
    
    func makeFactory() -> ProductModelFactory {
        ProductModelFactoryImp()
    }
    
    func test_single_product() {
        let factory = makeFactory()
        let given = products[0]
        let expected = map(network: given)
        
        XCTAssertTrue(factory.make(from: given) == expected)
    }
    
    func test_multiple_products() {
        let factory = makeFactory()
        let given = products
        let expected = given.map(map(network:))
        
        let result = factory.make(from: given)
        
        XCTAssert(expected == result)
    }
    
    private func map(network: ProductNetworkModel) -> Product {
        Product(
            id: network.id,
            title: network.title,
            price: network.price,
            description: network.description,
            category: Category(rawValue: network.category),
            image: network.image,
            rating: Rating(rate: network.rating.rate, count: network.rating.count),
            amountLeft: network.rating.count
        )
    }
}
