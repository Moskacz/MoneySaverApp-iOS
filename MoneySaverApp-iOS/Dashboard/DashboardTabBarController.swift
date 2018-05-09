//
//  DashboardTabBarController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 02.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MMFoundation

enum DashboardTab {
    case transactionsList
    case budget
    case stats
}

class DashboardTabBarController: UITabBarController {
    
    var centerButtonTapCallback = {}

    
    override var viewControllers: [UIViewController]? {
        didSet {
            setupTabBar()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func select(tab: DashboardTab) {
        switch tab {
        case .transactionsList:
            selectedIndex = 0
        case .budget:
            selectedIndex = 1
        case .stats:
            selectedIndex = 3
        }
    }
    
    // MARK: UITabBar
    
    private func setupTabBar() {
        setupTabBarAppearance()
        addTabBrCenterButton()
    }
    
    private func setupTabBarAppearance() {
        tabBar.tintColor = UIColor.appOrange
    }
    
    private func addTabBrCenterButton() {
        let button = GradientButton()
        button.gradient = Gradients.activeElement
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.setTitle("+", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        button.addBottomShadow()
        button.backgroundColor = UIColor.appOrange
        let buttonSize = CGFloat(60)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.layer.cornerRadius = buttonSize * 0.5
        tabBar.addSubview(button)
        button.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: buttonSize * 0.2).isActive = true
        button.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func centerButtonTapped() {
        centerButtonTapCallback()
    }
}

extension DashboardTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return !isMiddle(viewController: viewController)
    }
    
    private func isMiddle(viewController: UIViewController) -> Bool {
        guard viewControllers?.count == 5 else { return false }
        return viewController === viewControllers?[2]
    }
}
