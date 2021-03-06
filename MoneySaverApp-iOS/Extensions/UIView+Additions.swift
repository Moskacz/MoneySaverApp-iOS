//
//  UIView+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 29.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore

// MARK: Effects
extension UIView {
    func addBottomShadow() {
        layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
    }
}

// MARK: Error state
extension UIView {
    func displayAsIncorrect() {
        let backgroundColor = self.backgroundColor
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.autoreverse], animations: {
            self.backgroundColor = AppColor.redDark.value
        }, completion: { (_) in
            self.backgroundColor = backgroundColor
        })
    }
}
