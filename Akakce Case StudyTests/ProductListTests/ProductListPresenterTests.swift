//
//  ProductListPresenterTests.swift
//  Akakce Case StudyTests
//
//  Created by Gungor Basa on 8/5/24.
//

import XCTest
@testable import Akakce_Case_Study

final class ProductListPresenterTests: XCTestCase {
    private let productMocks = [
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
    
    @MainActor
    func test_on_view_did_load() async throws {
        let products = productMocks
        let horizontalProducts = [productMocks.first!]
        let interactorMock = ProductListInteractorMock(products: products, horizontalProducts: horizontalProducts)
        let expectation1 = XCTestExpectation(description: "Filled horizontal products")
        let expectation2 = XCTestExpectation(description: "Filled products")
        let viewMock = ProductListViewMock(expectations: [expectation1, expectation2])
        let routerMock = ProductListRouterMock()
        
        let presenter = ProductListPresenterImp(interactor: interactorMock)
        presenter.view = viewMock
        presenter.router = routerMock
        
        // onViewDidLoad calls Task so we need to wait for 2 expectations
        presenter.onViewDidLoad()
        
        await fulfillment(of: [expectation1, expectation2], timeout: 1.0)
        
        XCTAssertEqual(viewMock.actions.count, 2)
        if case .horizontalProducts(let horizontalItems) = viewMock.actions.first {
            XCTAssertEqual(horizontalItems.count, horizontalProducts.count)
        } else {
            XCTFail("Expected horizontalProducts action")
        }
        
        if case .products(let items) = viewMock.actions.last {
            XCTAssertEqual(items.count, products.count)
        } else {
            XCTFail("Expected products action")
        }
    }
    
    @MainActor
    func test_on_tap_product_collection_view_cell() async throws {
        let interactorMock = ProductListInteractorMock(products: [], horizontalProducts: [])
        let viewMock = ProductListViewMock()
        let routerMock = ProductListRouterMock()
        
        let presenter = ProductListPresenterImp(interactor: interactorMock)
        presenter.view = viewMock
        presenter.router = routerMock
        
        let item = ProductListCollectionViewCell.State(
            id: 1, 
            image: "img1",
            title: "Title1",
            price: 11.11,
            amountLeft: 123
        )
        
        presenter.onTapProductCollectionViewCell(item: item)
        
        XCTAssertEqual(routerMock.routes.count, 1)
        if case .details(let id) = routerMock.routes.first {
            XCTAssertEqual(id, item.id)
        } else {
            XCTFail("Expected details route")
        }
    }
    
    @MainActor
    func test_on_tap_product_list_header_cell() {
        let interactorMock = ProductListInteractorMock(products: [], horizontalProducts: [])
        let viewMock = ProductListViewMock()
        let routerMock = ProductListRouterMock()
        
        let presenter = ProductListPresenterImp(interactor: interactorMock)
        presenter.view = viewMock
        presenter.router = routerMock
        
        let item = ProductListHeaderCell.State(
            id: 2,
            image: "img2",
            title: "Title2",
            price: 22.22
        )
        
        presenter.onTapProductListHeaderCell(item: item)
        
        XCTAssertEqual(routerMock.routes.count, 1)
        if case .details(let id) = routerMock.routes.first {
            XCTAssertEqual(id, item.id)
        } else {
            XCTFail("Expected details route")
        }
    }
}
