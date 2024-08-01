//
//  ProductListRouter.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import UIKit

enum ProductListRoute {
    case details(id: Int)
}

protocol ProductListRouter {
    @MainActor
    func route(to: ProductListRoute)
}

struct ProductListRouterImp: ProductListRouter {
    let view: UIViewController
    
    func route(to: ProductListRoute) {
        switch to {
        case .details:
            let vc = UIViewController()
            view.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
