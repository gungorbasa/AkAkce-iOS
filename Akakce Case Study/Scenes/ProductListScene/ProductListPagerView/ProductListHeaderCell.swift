//
//  ProductListHeaderCell.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import UIKit

final class ProductListHeaderCell: UICollectionViewCell, Reusable {
    struct State: Identifiable, Equatable, Hashable {
        let id: Int
        let image: String
        let title: String
        let price: Double
        
        var formattedPrice: String { String(format: "%.1f", price) + " TL" }
    }
    
    private let horizontalStackView = UIStackView.autolayoutView(axis: .horizontal)
    private let titleLabel = UILabel.autolayoutView()
    private let priceLabel = UILabel.autolayoutView()
    private let imageView = UIImageView.autolayoutView()
    private let verticalStackView = UIStackView.autolayoutView(axis: .vertical)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func configure(with state: State) {
        // TODO: Setup ImageView with caching
        titleLabel.text = state.title
        priceLabel.text = state.formattedPrice
    }
}

private extension ProductListHeaderCell {
    func setup() {
        contentView.addSubview(horizontalStackView)
        
        setupHorizontalStackView()
        setupImageView()
        setupVerticalStackView()
        setupTitleLabel()
        setupPriceLabel()
        
        NSLayoutConstraint.activate(
            [
                horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ]
        )
    }
    
    func setupHorizontalStackView() {
        horizontalStackView.addArrangedSubview(imageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
    }
    
    func setupImageView() {
        imageView.backgroundColor = .white
        
        NSLayoutConstraint.activate(
            [
                imageView.heightAnchor.constraint(equalToConstant: 120),
                imageView.widthAnchor.constraint(equalToConstant: 80)
            ]
        )
    }
    
    func setupVerticalStackView() {
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(priceLabel)
    }
    
    func setupTitleLabel() {
        titleLabel.textColor = .gray
    }
    
    func setupPriceLabel() {
        priceLabel.textColor = .black
        priceLabel.font = .boldSystemFont(ofSize: 16)
    }
}
