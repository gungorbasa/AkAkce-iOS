//
//  UIView.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

import UIKit

extension UIView {
    /// Initializes autolayout `view` instance
    class func autolayoutView() -> Self {
        let instance = self.init()
        instance.translatesAutoresizingMaskIntoConstraints = false
        return instance
    }
    
    /// Tranforms existing view into autolayout
    func autolayoutView() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIStackView {
    /// Initializes autolayout `stackView` instance with axis
    class func autolayoutView(axis: NSLayoutConstraint.Axis) -> Self {
        let instance = self.init()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.axis = axis
        return instance
    }
}
