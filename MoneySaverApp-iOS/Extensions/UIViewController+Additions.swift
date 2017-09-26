//
//  UIViewController+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 26.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class var defaultStoryboardIdentifier: String {
        get {
            return String(describing: self)
        }
    }
}
