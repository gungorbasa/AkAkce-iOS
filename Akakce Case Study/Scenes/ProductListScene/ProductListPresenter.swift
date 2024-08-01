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

@MainActor
final class ProductListPresenterImp: ProductListPresenter {
    private let interactor: ProductListInteractor
    
    weak var view: ProductListView?
    
    init(interactor: ProductListInteractor) {
        self.interactor = interactor
    }
    
    func onViewDidLoad() {
        Task {
            do {
                let (products, horizontalProducts) =  try await fetchData()
                let horizontalItems = horizontalProducts.map {
                    ProductListHeaderCell.State(
                        id: $0.id,
                        image: $0.image,
                        title: $0.title,
                        price: $0.price
                    )
                }
                
                let items = products.map {
                    ProductListCollectionViewCell.State(
                        id: $0.id,
                        image: $0.image,
                        title: $0.title,
                        price: $0.price,
                        amountLeft: $0.rating.count // Decided to use this field for amount left
                    )
                }
                view?.apply(action: .horizontalProducts(horizontalItems))
                view?.apply(action: .products(items))
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
