//
//  ProductModelFactory.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/4/24.
//

import Foundation

protocol ProductModelFactory: Sendable {
    func make(from networkModel: ProductNetworkModel) -> Product
    func make(from networkModels: [ProductNetworkModel]) -> [Product]
}

final class ProductModelFactoryImp: ProductModelFactory {
    func make(from networkModel: ProductNetworkModel) -> Product {
        Product(
            id: networkModel.id,
            title: networkModel.title,
            price: networkModel.price,
            description: networkModel.description,
            category: Category(rawValue: networkModel.category),
            image: networkModel.image,
            rating: Rating(rate: networkModel.rating.rate, count: networkModel.rating.count),
            amountLeft: networkModel.rating.count
        )
    }
    
    func make(from networkModels: [ProductNetworkModel]) -> [Product] {
        networkModels.map(make(from:))
    }
}
