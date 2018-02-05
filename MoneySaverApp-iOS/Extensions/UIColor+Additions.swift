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

extension UIColor {
    static var appBlack = #colorLiteral(red: 0.168627451, green: 0.1803921569, blue: 0.2039215686, alpha: 1)
    static var appRed = #colorLiteral(red: 0.9960784314, green: 0.4, blue: 0.3529411765, alpha: 1)
    static var appOrange = #colorLiteral(red: 0.9960784314, green: 0.6, blue: 0.4196078431, alpha: 1)
    static var appBrown = #colorLiteral(red: 0.631372549, green: 0.4549019608, blue: 0.4235294118, alpha: 1)
    static var appPurple = #colorLiteral(red: 0.6588235294, green: 0.3411764706, blue: 0.9960784314, alpha: 1)
    static var appGreen = #colorLiteral(red: 0.2980392157, green: 0.8705882353, blue: 0.7843137255, alpha: 1)
    static var appLightPurple = #colorLiteral(red: 0.631372549, green: 0.7450980392, blue: 0.9019607843, alpha: 1)
}
