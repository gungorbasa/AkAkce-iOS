//
//  UICollectionView.swift
//  Akakce Case Study
//
//  Created by Gungor Basa on 8/1/24.
//

#if canImport(UIKit)
import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String { String(describing: self) }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) where T: Reusable {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T? where T: Reusable {
        dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T
    }
}
#endif
