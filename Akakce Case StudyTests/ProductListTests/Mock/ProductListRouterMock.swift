//
//  ProductListRouterMock.swift
//  Akakce Case StudyTests
//
//  Created by Gungor Basa on 8/5/24.
//

import XCTest
@testable import Akakce_Case_Study

class ProductListRouterMock: ProductListRouter {
    var routes: [ProductListRoute] = []
    
    func route(to destination: ProductListRoute) {
        routes.append(destination)
    }
}
