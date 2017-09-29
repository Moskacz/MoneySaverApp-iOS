//
//  UIView+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 29.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

extension UIView {
    
    func matchParent(edgeInsets: UIEdgeInsets = UIEdgeInsets.zero) {
        pinToParentTop(constant: edgeInsets.top)
        pinToParentBottom(constant: edgeInsets.bottom)
        pinToParentLeading(constant: edgeInsets.left)
        pinToParentTrailing(constant: edgeInsets.right)
    }
    
    func pinToParentLeading(constant: CGFloat = 0.0) {
        guard let parent = superview else { return }
        leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: constant).isActive = true
    }
    
    func pinToParentTrailing(constant: CGFloat = 0.0) {
        guard let parent = superview else { return }
        trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: constant).isActive = true
    }
    
    func pinToParentTop(constant: CGFloat = 0.0) {
        guard let parent = superview else { return }
        topAnchor.constraint(equalTo: parent.topAnchor, constant: constant).isActive = true
    }
    
    func pinToParentBottom(constant: CGFloat = 0.0) {
        guard let parent = superview else { return }
        bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: constant).isActive = true
    }
}
