//
//  ProductNetworkModel.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 7/31/24.
//

import Foundation

struct ProductNetworkModel: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: RatingNetworkModel
}
