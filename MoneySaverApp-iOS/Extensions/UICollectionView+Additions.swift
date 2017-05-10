//
//  UICollectionView+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 10.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueTypedCell<T>(withIdentifier identifier: String, forIndexPath path: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: identifier, for: path) as! T
    }
}
