//
//  ProductDetailsView.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import UIKit
import NukeUI
import Cosmos

final class ProductView: UIView {
    struct State: Equatable {
        let title: String
        let description: String
        let image: String
        let amountLeft: Int
        let price: Double
        let rating: Double
        
        var amountLeftText: String { "Only \(amountLeft) items left!" }
        var priceText: String { String(format: "%.2f", price) + " TL" }
    }
    
    private let scrollView = UIScrollView.autolayoutView()
    private let stackView = UIStackView.autolayoutView(axis: .vertical)
    private let imageView = LazyImageView.autolayoutView()
    private let titleLabel = UILabel.autolayoutView()
    private let descriptionLabel = UILabel.autolayoutView()
    private let amountLeftLabel = UILabel.autolayoutView()
    private let priceLabel = UILabel.autolayoutView()
    private let freeShippingLabel = UILabel.autolayoutView()
    private let starRatingView = CosmosView.autolayoutView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func configure(with state: State) {
        titleLabel.text = state.title
        descriptionLabel.text = state.description
        imageView.url = URL(string: state.image)
        amountLeftLabel.text = state.amountLeftText
        priceLabel.text = state.priceText
        starRatingView.rating = state.rating
        freeShippingLabel.text = "Free Shipping!"
        
        UIView.animate(withDuration: 1) { [weak self] in
            self?.stackView.layer.opacity = 1.0
        }
    }
}

private extension ProductView {
    func setup() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        setupScrollView()
        setupStackView()
        setupLabels()
        setupStarRatingView()
        setupImageView()
    }
    
    func setupScrollView() {
        NSLayoutConstraint.activate(
            [
                scrollView.topAnchor.constraint(equalTo: topAnchor),
                scrollView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                scrollView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
            ]
        )
    }
    
    func setupStackView() {
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(amountLeftLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(freeShippingLabel)
        stackView.addArrangedSubview(starRatingView)
        
        stackView.layer.opacity = 0
        
        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                stackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor),
                stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            ]
        )
    }
    
    func setupLabels() {
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = .preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        
        amountLeftLabel.font = .preferredFont(forTextStyle: .body)
        amountLeftLabel.textColor = .black
        
        priceLabel.font = .preferredFont(forTextStyle: .headline)
        priceLabel.textColor = .black
        
        freeShippingLabel.font = .preferredFont(forTextStyle: .callout)
        freeShippingLabel.textColor = .systemGreen
    }
    
    func setupImageView() {
        imageView.imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor).isActive = true
    }
    
    func setupStarRatingView() {
        starRatingView.isUserInteractionEnabled = false
    }
}
