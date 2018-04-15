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
    
    var editBudgetTapCallback = {}
    
    @IBOutlet private weak var stackView: UIStackView?
    @IBOutlet private weak var pieChart: PieChartView?
    @IBOutlet private weak var combinedChart: CombinedChartView?
    
    var viewModel: BudgetViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    var setupBudgetViewModel: SetupBudgetViewModel?
    
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
            addEditButton()
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
        guard let storyboard = storyboard else { return }
        let setupBudgetVC: SetupBudgetViewController = storyboard.instantiate()
        setupBudgetVC.viewModel = setupBudgetViewModel
        addViewController(asChild: setupBudgetVC)
    }
    
    private func removeSetupBudgetViewController() {
        removeChildViewControllers()
    }
    
    // MARK: Edit budget
    
    private func addEditButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func editButtonTapped() {
        editBudgetTapCallback()
    }
}

extension BudgetViewController: BudgetViewModelDelegate {
    
    func budget(setUp: Bool) {
        guard setUp else { return }
        setupCharts()
        addEditButton()
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
