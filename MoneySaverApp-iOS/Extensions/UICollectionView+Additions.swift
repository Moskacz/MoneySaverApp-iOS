//
//  UICollectionView+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 10.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueTypedCell<T:UICollectionViewCell>(withIdentifier identifier: String, forIndexPath path: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: identifier, for: path) as! T
    }
    
    func dequeueCell<T:UICollectionViewCell>(forIndexPath path: IndexPath) -> T {
        return dequeueTypedCell(withIdentifier: T.defaultReuseId, forIndexPath: path)
    }
    
    func register(cell: UICollectionViewCell.Type) {
        register(cell.defaultNib, forCellWithReuseIdentifier: cell.defaultReuseId)
    }
}

extension UICollectionViewCell {
    
    class var className: String {
        return String(describing: self)
    }
    
    class var defaultReuseId: String {
        return className
    }
    
    class var defaultNib: UINib {
        return UINib(nibName: className, bundle: nil)
    }
}
