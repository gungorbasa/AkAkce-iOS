//
//  ProductEndpoints.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 7/31/24.
//

import Foundation
import Networking

enum ProductEndpoints: Routing {
    var host: String { "https://fakestoreapi.com" }
    
    var path: String {
        switch self {
        case .product:
            return "/products"
        case .horizontalProduct:
            return "/products"
        case .productDetails(let id):
            return "/products/\(id)"
        }
    }
    
    var headers: [String : String] { [:] }
    
    var parameters: [String : Any] {
        switch self {
        case .product:
            return [:]
        case .horizontalProduct:
            return ["limit": "5"]
        case .productDetails:
            return [:]
        }
    }
    
    var body: [String : Any] { [:] }
    
    var method: HTTPMethod { .get }
    
    case product
    case horizontalProduct
    case productDetails(id: String)
}
