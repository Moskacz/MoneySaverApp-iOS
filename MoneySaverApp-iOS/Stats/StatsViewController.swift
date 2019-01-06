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
import MMFoundation

class StatsViewController: UIViewController {
    
    var presenter: StatsPresenterProtocol!
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl?
    @IBOutlet private weak var expensesPerTimeChart: BarChartView!
    @IBOutlet private weak var incomesPerTimeChart: BarChartView!
    @IBOutlet private weak var expensesPerCategory: BarChartView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Stats", image: #imageLiteral(resourceName: "stats"), selectedImage: #imageLiteral(resourceName: "stats"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCharts()
        presenter.start()
    }
    
    private func configureCharts() {
        [expensesPerTimeChart!, incomesPerTimeChart!].forEach {
            $0.highlightFullBarEnabled = false
            $0.scaleXEnabled = false
            $0.scaleYEnabled = false
            $0.drawValueAboveBarEnabled = true
            $0.drawGridBackgroundEnabled = false
            $0.drawBordersEnabled = false
            $0.rightAxis.enabled = false
            $0.leftAxis.drawGridLinesEnabled = false
            $0.xAxis.drawGridLinesEnabled = false
            $0.xAxis.labelPosition = .bottom
        }
    }
    
    // MARK: UI actions
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        presenter.selectedGroupingIndex = sender.selectedSegmentIndex
    }
}

extension StatsViewController: StatsUIProtocol {
    
    func setGrouping(items: [SegmentedControlItem]) {
        segmentedControl?.items = items
    }
    
    func selectGrouping(index: Int) {
        segmentedControl?.selectedSegmentIndex = index
    }
    
    func showExpenses(data: BarChartData) {
        expensesPerTimeChart?.data = data
        expensesPerTimeChart?.notifyDataSetChanged()
    }
    
    func showIncomes(data: BarChartData) {
        incomesPerTimeChart?.data = data
        incomesPerTimeChart?.notifyDataSetChanged()
    }
    
    func showCategoryExpenses(data: PieChartData) {
        
    }
}

