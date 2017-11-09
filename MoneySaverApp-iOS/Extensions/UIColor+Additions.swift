//
//  UIColor+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

extension UIColor {
    
    func encode() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject:self)
    }
    
    class func color(fromData data: Data) -> UIColor? {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? UIColor
    }
    
}
