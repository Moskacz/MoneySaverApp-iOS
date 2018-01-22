//
//  DashboardTabBarController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 02.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

enum DashboardTab {
    case transactionsList
    case budget
    case stats
}

class DashboardTabBarController: UITabBarController {
    
    func select(tab: DashboardTab) {
        switch tab {
        case .transactionsList:
            selectedIndex = 0
        case .budget:
            selectedIndex = 1
        case .stats:
            selectedIndex = 2
        }
    }
    
}
