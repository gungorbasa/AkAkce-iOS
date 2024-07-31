//
//  ProductListViewController.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 7/31/24.
//

import UIKit

final class ProductListViewController: UIViewController {
    private var presenter: ProductListPresenter
    
    init(presenter: ProductListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        presenter.onViewDidLoad()
    }
}
