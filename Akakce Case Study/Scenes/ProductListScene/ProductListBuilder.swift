//
//  ProductListBuilder.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 7/31/24.
//

import UIKit
import Networking

enum ProductListBuilder {
    @MainActor 
    static func make() -> UIViewController {
        let networking = NativeNetwork(decoder: .init())
        let service = ProductListServiceImp(network: networking)
        let interactor = ProductListInteractorImp(service: service)
        let presenter = ProductListPresenterImp(interactor: interactor)
        let view = ProductListViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
