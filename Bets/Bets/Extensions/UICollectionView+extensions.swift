//
//  UICollectionView+extensions.swift
//  Bets
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import UIKit

extension UICollectionView {

    internal func registerCell<T: UICollectionViewCell>(type: T.Type) {
        register(type, forCellWithReuseIdentifier: type.identifier)
    }

    internal func dequeueCell<T: UICollectionViewCell>(type: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }

}
