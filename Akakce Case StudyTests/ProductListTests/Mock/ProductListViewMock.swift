//
//  ProductListViewMock.swift
//  Akakce Case StudyTests
//
//  Created by Gungor Basa on 8/5/24.
//

import XCTest
@testable import Akakce_Case_Study

class ProductListViewMock: ProductListView {
    var actions: [ProductListViewAction] = []
    var expectations: [XCTestExpectation]
    
    init(expectations: [XCTestExpectation] = []) {
        self.expectations = expectations
    }
    
    func apply(action: ProductListViewAction) {
        actions.append(action)
        if expectations.count >= actions.count {
            expectations[actions.count - 1].fulfill()
        }
    }
}
