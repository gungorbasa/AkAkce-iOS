//
//  ProductListBuilder.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 7/31/24.
//

import UIKit

enum ProductListBuilder {
    @MainActor 
    static func make() -> UIViewController {
        return ProductListViewController(nibName: nil, bundle: nil)
    }
}
