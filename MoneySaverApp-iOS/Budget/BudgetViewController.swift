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
    
    @IBOutlet private weak var stackView: UIStackView?
    @IBOutlet private weak var pieChart: PieChartView?
    @IBOutlet private weak var combinedChart: CombinedChartView?
    
    override var tabBarItem: UITabBarItem! {
        get {
            return UITabBarItem(title: "Budget", image: nil, selectedImage: nil)
        }
        set {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPieChart()
        setupCombinedChart()
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
    
    private func setupCombinedChart() {
        let data = CombinedChartData()
        let barEntries = [BarChartDataEntry(x: 0, y: 1),
                          BarChartDataEntry(x: 1, y: 2),
                          BarChartDataEntry(x: 2, y: 3)]
        let barDataSet = BarChartDataSet(values: barEntries, label: "bar")
        barDataSet.barBorderColor = UIColor.red
        data.barData = BarChartData(dataSet: barDataSet)
        
        let lineEntries = [ChartDataEntry(x: 0, y: 1),
                           ChartDataEntry(x: 1, y: 2),
                           ChartDataEntry(x: 2, y: 3)]
        let lineDataSet = LineChartDataSet(values: lineEntries, label: "line")
        lineDataSet.colors = [UIColor.orange]
        data.lineData = LineChartData(dataSet: lineDataSet)
        
        combinedChart?.data = data
        combinedChart?.notifyDataSetChanged()
    }
    
    override func willTransition(to newCollection: UITraitCollection,
                                 with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] (_) in
            switch newCollection.verticalSizeClass {
            case .compact, .unspecified:
                self?.stackView?.axis = .horizontal
            case .regular:
                self?.stackView?.axis = .vertical
            }
        }, completion: nil)
    }
}
