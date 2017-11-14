//
//  BudgetViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 26.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import Charts

class BudgetViewController: UIViewController {
    
    @IBOutlet private weak var pieChart: PieChartView?
    
    override var tabBarItem: UITabBarItem! {
        get {
            return UITabBarItem(title: "Budget", image: nil, selectedImage: nil)
        }
        set {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPieChart()
    }
    
    private func setupPieChart() {
        let values = [PieChartDataEntry(value: 1, label: "1"),
                      PieChartDataEntry(value: 2, label: "3"),
                      PieChartDataEntry(value: 3, label: "2")]
        let dataSet = PieChartDataSet(values: values, label: "data set")
        dataSet.colors = [UIColor.blue, UIColor.orange, UIColor.red]
        pieChart?.data = PieChartData(dataSet: dataSet)
        pieChart?.holeColor = UIColor.clear
        pieChart?.notifyDataSetChanged()
    }
}
