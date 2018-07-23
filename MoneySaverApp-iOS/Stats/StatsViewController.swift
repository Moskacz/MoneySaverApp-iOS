//
//  StatsViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 26.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore
import Charts

class StatsViewController: UIViewController {
    
    var viewModel: StatsViewModel?
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl?
    @IBOutlet private weak var expensesPerTimeChart: BarChartView?
    @IBOutlet private weak var incomesPerTimeChart: BarChartView?
    @IBOutlet private weak var expensesPerCategory: BarChartView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Stats", image: #imageLiteral(resourceName: "stats"), selectedImage: #imageLiteral(resourceName: "stats"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGroupingControl()
    }
    
    private func setupGroupingControl() {
        guard let viewModel = viewModel else { return }
        segmentedControl?.items = viewModel.groupingItems
        segmentedControl?.selectedSegmentIndex = viewModel.selectedGroupingIntex
        segmentedControl?.tintColor = AppColor.activeElement.value
    }
    
    // MARK: UI actions
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        viewModel?.selectedGroupingIntex = sender.selectedSegmentIndex
    }
}

