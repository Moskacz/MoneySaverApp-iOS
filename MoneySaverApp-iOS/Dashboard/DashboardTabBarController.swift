//
//  DashboardTabBarController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 02.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class DashboardTabBarController: UITabBarController {
    
    func setupItemsTitles() {
        tabBar.items?[0].title = "Transactions"
        tabBar.items?[1].title = "Budget"
        tabBar.items?[2].title = "Stats"
    }
    
}
