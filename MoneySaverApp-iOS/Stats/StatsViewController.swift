//
//  StatsViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 26.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import ScrollableGraphView

class StatsViewController: UIViewController {
    
    override lazy var tabBarItem: UITabBarItem! = {
        return UITabBarItem(title: "Stats", image: #imageLiteral(resourceName: "stats"), selectedImage: #imageLiteral(resourceName: "stats"))
    }()
}
