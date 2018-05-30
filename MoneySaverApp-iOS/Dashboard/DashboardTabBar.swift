//
//  DashboardTabBar.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.05.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import MMFoundation

class DashboardTabBar: UITabBar {
    
    private(set) var centerButton: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        setupTabBarAppearance()
        addTabBrCenterButton()
    }
    
    private func setupTabBarAppearance() {
        tintColor = AppColor.activeElement.value
    }
    
    private func addTabBrCenterButton() {
        let button = UIButton()
//        button.update(with: AppGradient.activeElement.value)
        button.backgroundColor = AppColor.activeElement.value
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.setTitle("+", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        let buttonSize = CGFloat(60)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.layer.cornerRadius = buttonSize * 0.5
        addSubview(button)
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: topAnchor, constant: buttonSize * 0.2).isActive = true
        self.centerButton = button
    }
    
    // MARK: Responder chain
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let button = centerButton, button.frame.contains(point) else {
            return super.hitTest(point, with: event)
        }
        return button
    }
}
