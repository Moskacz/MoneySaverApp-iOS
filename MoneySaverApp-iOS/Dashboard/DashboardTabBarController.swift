//
//  DashboardTabBarController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 02.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class DashboardTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupNavigationItem(withViewController: viewControllers?.first)
    }
    
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        setupNavigationItem(withViewController: viewController)
    }
    
    private func setupNavigationItem(withViewController viewController: UIViewController?) {
        guard let buttonProvider = viewController as? BarButtonProvider else {
            navigationItem.rightBarButtonItem = nil
            return
        }
        
        navigationItem.rightBarButtonItem = buttonProvider.barButton()
    }
}
