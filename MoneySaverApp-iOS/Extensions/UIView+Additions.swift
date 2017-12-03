//
//  UIView+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 29.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

// MARK: AutoLayout
extension UIView {
    
    func matchParent(edgeInsets: UIEdgeInsets = UIEdgeInsets.zero, priority: UILayoutPriority = .required) {
        matchParentHorizontally(edges: edgeInsets, priority: priority)
        matchParentVertically(edges: edgeInsets, priority: priority)
    }
    
    func matchParentHorizontally(edges: UIEdgeInsets = UIEdgeInsets.zero, priority: UILayoutPriority = .required) {
        pinToParentLeading(constant: edges.left, priority: priority)
        pinToParentTrailing(constant: edges.right, priority: priority)
    }
    
    func matchParentVertically(edges: UIEdgeInsets = UIEdgeInsets.zero, priority: UILayoutPriority = .required) {
        pinToParentTop(constant: edges.top, priority: priority)
        pinToParentBottom(constant: edges.bottom, priority: priority)
    }
    
    func pinToParentLeading(constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let parent = superview else { return }
        let constraint = leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func pinToParentTrailing(constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let parent = superview else { return }
        let constraint = trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func pinToParentTop(constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let parent = superview else { return }
        let constraint = topAnchor.constraint(equalTo: parent.topAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func pinToParentBottom(constant: CGFloat = 0.0, priority: UILayoutPriority = .required) {
        guard let parent = superview else { return }
        let constraint = bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
}

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
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.autoreverse], animations: {
            self.backgroundColor = Theme.errorColor
        }, completion: { (_) in
            self.backgroundColor = UIColor.white
        })
    }
}
