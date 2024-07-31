//
//  ProductListPresenter.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 7/31/24.
//

import Foundation

protocol ProductListPresenter: Sendable {
    @MainActor
    func onViewDidLoad()
}

final class ProductListPresenterImp: ProductListPresenter {
    private let interactor: ProductListInteractor
    
    init(interactor: ProductListInteractor) {
        self.interactor = interactor
    }
    
    @MainActor
    func onViewDidLoad() {
        Task {
            do {
                let (products, horizontalProducts) =  try await fetchData()
                print(horizontalProducts)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

private extension ProductListPresenterImp {
    func fetchData() async throws -> (products: [Product], horizontalProducts: [Product]) {
        async let products = interactor.fetchProducts()
        async let horizontalProducts = interactor.fetchHorizontalProducts()
        
        let fetchedProducts = try await products
        let fetchedHorizontalProducts = try await horizontalProducts
        
        return (fetchedProducts, fetchedHorizontalProducts)
    }
}
