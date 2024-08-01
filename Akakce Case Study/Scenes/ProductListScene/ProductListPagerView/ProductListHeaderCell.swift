//
//  ProductListHeaderCell.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import UIKit
import NukeUI

final class ProductListHeaderCell: UICollectionViewCell, Reusable {
    struct State: Identifiable, Equatable, Hashable {
        let id: Int
        let image: String
        let title: String
        let price: Double
        
        var formattedPrice: String { String(format: "%.2f", price) + " TL" }
    }
    
    private let horizontalStackView = UIStackView.autolayoutView(axis: .horizontal)
    private let titleLabel = UILabel.autolayoutView()
    private let priceLabel = UILabel.autolayoutView()
    private let imageView = LazyImageView.autolayoutView()
    private let verticalStackView = UIStackView.autolayoutView(axis: .vertical)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        priceLabel.text = ""
        imageView.cancel()
    }
    
    func configure(with state: State) {
        imageView.url = URL(string: state.image)
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
                horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
            ]
        )
    }
    
    func setupHorizontalStackView() {
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 16
        horizontalStackView.addArrangedSubview(imageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
    }
    
    func setupImageView() {
        imageView.imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate(
            [
                imageView.widthAnchor.constraint(equalTo: horizontalStackView.widthAnchor, multiplier: 0.35),
                imageView.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor)
            ]
        )
    }
    
    func setupVerticalStackView() {
        verticalStackView.alignment = .leading
        verticalStackView.spacing = 8
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(priceLabel)
    }
    
    func setupTitleLabel() {
        titleLabel.textColor = .gray
        titleLabel.numberOfLines = 3
    }
    
    func setupPriceLabel() {
        priceLabel.textColor = .black
        priceLabel.font = .boldSystemFont(ofSize: 24)
    }
}
