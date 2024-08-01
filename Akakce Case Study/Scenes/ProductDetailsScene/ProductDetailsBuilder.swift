//
//  ProductDetailsBuilder.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import UIKit
import Networking

@MainActor
enum ProductDetailsBuilder {
    static func make(with id: Int) -> UIViewController {
        let networking = NativeNetwork(decoder: .init())
        let service = ProductDetailsServiceImp(networking: networking)
        let interactor = ProductDetailsInteractorImp(service: service)
        let presenter = ProductDetailsPresenterImp(interactor: interactor, productId: id)
        let view = ProductDetailsViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
