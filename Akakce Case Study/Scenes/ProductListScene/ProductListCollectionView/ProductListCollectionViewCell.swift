//
//  ProductListCollectionViewCell.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import UIKit
import NukeUI

final class ProductListCollectionViewCell: UICollectionViewCell, Reusable {
    struct State: Identifiable, Hashable {
        let id: Int
        let image: String
        let title: String
        let price: Double
        let amountLeft: Int
        
        var formattedPrice: String { String(format: "%.2f", price) + " TL" }
    }
    
    private let stackView = UIStackView.autolayoutView(axis: .vertical)
    private let imageView = LazyImageView.autolayoutView()
    private let titleLabel = UILabel.autolayoutView()
    private let priceLabel = UILabel.autolayoutView()
    private let amountLeftLabel = UILabel.autolayoutView()
    
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
        imageView.cancel()
    }
    
    func configure(with state: State) {
        imageView.url = URL(string: state.image)
        titleLabel.text = state.title
        priceLabel.text = state.formattedPrice
        amountLeftLabel.text = "\(state.amountLeft) left in stock!"
    }
}

private extension ProductListCollectionViewCell {
    func setup() {
        setupStackView()
        setupImageView()
        setupLabels()
    }
    
    func setupStackView() {
        contentView.addSubview(stackView)
        stackView.alignment = .center
        stackView.spacing = 8
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(UIView.autolayoutView())
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(amountLeftLabel)
        
        stackView.setCustomSpacing(0, after: priceLabel)
        
        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
            ]
        )
    }
    
    func setupImageView() {
        imageView.imageView.contentMode = .scaleAspectFit
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate(
            [
                imageView.heightAnchor.constraint(equalToConstant: 120)
            ]
        )
    }
    
    func setupLabels() {
        titleLabel.textColor = .gray
        titleLabel.numberOfLines = 2
        titleLabel.font = .preferredFont(forTextStyle: .subheadline)
        priceLabel.font = .preferredFont(forTextStyle: .headline)
        amountLeftLabel.font = .preferredFont(forTextStyle: .footnote)
    }
}
