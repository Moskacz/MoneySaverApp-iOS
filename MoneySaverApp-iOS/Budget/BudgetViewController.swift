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
    
    var viewModel: BudgetViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override var tabBarItem: UITabBarItem! {
        get {
            return UITabBarItem(title: "Budget", image: nil, selectedImage: nil)
        }
        set {}
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
    
    // MARK: SetupBudgetViewController
    
    private func displaySetupBudgetViewController() {
        guard let storyboard = storyboard, let model = viewModel else { return }
        let setupBudgetVC: SetupBudgetViewController = storyboard.instantiateFromStoryboard()
        setupBudgetVC.viewModel = SetupBudgetViewModel(budgetRepository: model.budgetRepository)
        addViewController(asChild: setupBudgetVC)
    }
    
    private func removeSetupBudgetViewController() {
        removeChildViewControllers()
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
