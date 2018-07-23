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
    
    var editBudgetTapCallback = {}
    
    @IBOutlet private weak var pieChart: PieChartView?
    @IBOutlet private weak var combinedChart: CombinedChartView?
    
    var viewModel: BudgetViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Budget", image: #imageLiteral(resourceName: "money_bag"), selectedImage: #imageLiteral(resourceName: "money_bag"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        guard let model = viewModel else { return }
        if model.isBudgetSetUp() {
            setupCharts()
        } else {
            displaySetupBudgetViewController()
        }
    }
    
    private func setupCharts() {
        pieChart?.holeColor = UIColor.clear
        pieChart?.data = viewModel?.pieChartData()
        pieChart?.notifyDataSetChanged()
        combinedChart?.data = viewModel?.combinedChartData()
        combinedChart?.notifyDataSetChanged()
    }
    
    // MARK: SetupBudgetViewController
    
    private func displaySetupBudgetViewController() {
        guard let storyboard = storyboard else { return }
        let setupBudgetVC: SetupBudgetViewController = storyboard.instantiate()
        setupBudgetVC.viewModel = viewModel?.makeSetupBudgetViewModel()
        addViewController(asChild: setupBudgetVC)
    }
    
    private func removeSetupBudgetViewController() {
        removeChildViewControllers()
    }
    
    // MARK: Edit budget
    
    @IBAction func editBudgetTapped(_ sender: UIButton) {
        editBudgetTapCallback()
    }
}

extension BudgetViewController: BudgetViewModelDelegate {
    
    func budget(setUp: Bool) {
        guard setUp else { return }
        setupCharts()
        removeChildViewControllers()
    }
    
    func pieChartDataUpdated(_ data: PieChartData) {
        pieChart?.data = data
        pieChart?.notifyDataSetChanged()
    }
    
    func combinedChartDataUpdated(_ data: CombinedChartData) {
        combinedChart?.data = data
        combinedChart?.notifyDataSetChanged()
    }
}
