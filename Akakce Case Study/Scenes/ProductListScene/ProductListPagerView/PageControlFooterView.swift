//
//  PageControlFooterView.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import UIKit
import Combine

final class PageControlFooterView: UIView, Reusable {
    struct PagingInfo: Equatable, Hashable {
        let currentPage: Int
    }
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl.autolayoutView()
        control.isUserInteractionEnabled = true
        return control
    }()
    
    private var pagingInfoToken: AnyCancellable?
    
    var currentPageIndicatorTintColor: UIColor? {
        get { pageControl.currentPageIndicatorTintColor }
        set { pageControl.currentPageIndicatorTintColor = newValue }
    }
    
    var pageIndicatorTintColor: UIColor? {
        get { pageControl.pageIndicatorTintColor }
        set { pageControl.pageIndicatorTintColor = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    deinit {
        Task { await cleanup() }
    }
    
    func configure(with numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
    }
    
    func subscribeTo(subject: PassthroughSubject<PagingInfo, Never>) {
        pagingInfoToken = subject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pagingInfo in
                self?.pageControl.currentPage = pagingInfo.currentPage
            }
    }
    
    private func setup() {
        backgroundColor = .clear
        addSubview(pageControl)
        
        pageControl.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate(
            [
                pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
                pageControl.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
    }
    
    @MainActor
    private func cleanup() {
        pagingInfoToken?.cancel()
        pagingInfoToken = nil
    }
}
