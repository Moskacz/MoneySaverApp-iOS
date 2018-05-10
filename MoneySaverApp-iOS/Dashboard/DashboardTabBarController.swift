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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupTabBar()
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
    
    private func setupTabBar() {
        let tabBar = self.tabBar as! DashboardTabBar
        tabBar.centerButton?.addTarget(self, action: #selector(centerTabBarButtonTapped), for: .touchUpInside)
    }
    
    @IBAction func centerTabBarButtonTapped() {
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
