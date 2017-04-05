//
//  UIStoryboard+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 05.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func instantiateTypeViewController<T>(withIdentifier identifier: String) -> T {
        return instantiateViewController(withIdentifier: identifier) as! T
    }
    
    static func getMain() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
}
