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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleView()
    }
    
    private func setupTitleView() {
        let groupings = [TransactionGrouping.day, TransactionGrouping.week, TransactionGrouping.month]
        let segmentedControl = UISegmentedControl(items: groupings.map { $0.title })
        navigationItem.titleView = segmentedControl
    }

}

extension StatsViewController: ScrollableGraphViewDataSource {
    
    func label(atIndex pointIndex: Int) -> String {
        return "\(pointIndex)"
    }
    
    func numberOfPoints() -> Int {
        return 100
    }
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        return Double(pointIndex)
    }
}
