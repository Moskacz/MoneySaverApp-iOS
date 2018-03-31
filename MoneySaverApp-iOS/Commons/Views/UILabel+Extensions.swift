//
//  UILabel+Extensions.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 31.03.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit

extension UILabel {
    
    func set(text: String?, animated: Bool) {
        if animated {
            UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                self.text = text
            }, completion: nil)
        } else {
            self.text = text
        }
    }
}
