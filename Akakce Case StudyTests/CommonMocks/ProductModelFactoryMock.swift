//
//  ProductModelFactoryMock.swift
//  Akakce Case StudyTests
//
//  Created by Gungor Basa on 8/4/24.
//

import Foundation
@testable import Akakce_Case_Study

struct ProductModelFactoryMock: ProductModelFactory {
    let product: Product
    let products: [Product]
    
    func make(from networkModel: ProductNetworkModel) -> Product { product }
    
    func make(from networkModels: [ProductNetworkModel]) -> [Product] { products }
}
