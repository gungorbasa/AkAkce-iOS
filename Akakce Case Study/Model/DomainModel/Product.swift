//
//  Product.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 7/31/24.
//

import Foundation

struct Product: Equatable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}
