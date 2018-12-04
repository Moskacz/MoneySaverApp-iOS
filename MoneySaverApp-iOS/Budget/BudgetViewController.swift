//
//  BudgetViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 26.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore
import Charts

class BudgetViewController: UIViewController {
    
    var presenter: BudgetPresenterProtocol!
    
    @IBOutlet private weak var pieChart: PieChartView?
    @IBOutlet private weak var combinedChart: CombinedChartView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Budget", image: #imageLiteral(resourceName: "money_bag"), selectedImage: #imageLiteral(resourceName: "money_bag"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
        pieChart?.holeColor = UIColor.clear
    }
    
    // MARK: Edit budget
    
    @IBAction func editBudgetTapped(_ sender: UIButton) {
        presenter.requestBudgetAmountEdit()
    }
}

extension BudgetViewController: BudgetUIProtocol {
    func showBudgetNotSetup() {
        
    }
    
    func showBudgetPieChart(with data: PieChartData) {
        pieChart?.data = data
        pieChart?.notifyDataSetChanged()
    }
    
    func showSpendingsChart(with data: CombinedChartData) {
        combinedChart?.data = data
        combinedChart?.notifyDataSetChanged()
    }
}
