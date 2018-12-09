//
//  RootFlowController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 05.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore

enum FlowState {
    case transactionsList
    case budget
    case transactionData
}

class RootFlowController: FlowController {
    
    private weak var applicationDelegate: AppDelegate?
    private weak var tabBarController: DashboardTabBarController?
    private weak var transactionsOverviewVC: TransactionsOverviewViewController?
    
    private let storyboard: UIStoryboard
    private let presentationManager = CardStylePresentationManager()
    
    var animatedTransitions: Bool = true

    init(applicationDelegate: AppDelegate?,
         storyboard: UIStoryboard) {
        self.applicationDelegate = applicationDelegate
        self.storyboard = storyboard
    }
    
    func startFlow() {
        setupRootFlowController()
    }
    
    func setup(flowState: FlowState) {
        guard tabBarController?.presentedViewController == nil else {
            tabBarController?.dismiss(animated: self.animatedTransitions, completion: {
                self.setup(flowState: flowState)
            })
            return
        }
        
        switch flowState {
        case .transactionsList:
            tabBarController?.select(tab: .transactionsList)
        case .budget:
            tabBarController?.select(tab: .budget)
        case .transactionData:
            tabBarController?.select(tab: .transactionsList)
            presentTransactionDataViewController()
        }
    }
    
    private func setupRootFlowController() {
        let tabBarVC: DashboardTabBarController = storyboard.instantiate()
        
        tabBarVC.viewControllers = [transactionsOverviewViewController(),
                                    budgetViewController(),
                                    UIViewController(),
                                    statsViewController(),
                                    settingsViewController()]
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarVC
        applicationDelegate?.window = window
        applicationDelegate?.window?.makeKeyAndVisible()
        self.tabBarController = tabBarVC
        
        tabBarVC.centerButtonTapCallback = {
            self.presentTransactionDataViewController()
        }
    }
    
    private func transactionsOverviewViewController() -> TransactionsOverviewViewController {
        let viewController: TransactionsOverviewViewController = storyboard.instantiate()
        
        viewController.configureSummaryVC = { viewController in
            self.configure(summaryVC: viewController)
        }
        
        self.transactionsOverviewVC = viewController
        return viewController
    }
    
    private func configure(summaryVC: TransactionsSummaryViewController) {
        summaryVC.presenter = Factory.transactionsSummaryPresenter(display: summaryVC, router: self)
    }
    
    private func budgetViewController() -> BudgetViewController {
        let viewController: BudgetViewController = storyboard.instantiate()
        viewController.presenter = Factory.budgetPresenter(routing: self, userInterface: viewController)
        return viewController
    }
    
    private func statsViewController() -> StatsViewController {
        let viewController: StatsViewController = storyboard.instantiate()
        viewController.presenter = Factory.statsPresenter(userInterface: viewController)
        return viewController
    }
    
    private func presentTransactionDataViewController() {
        let viewController: TransactionDataViewController = storyboard.instantiate()
        viewController.presenter = Factory.transactionDataPresenter(userInterface: viewController,
                                                                    router: self)
        
        let navControlloer = TransactionDataNavigationController(rootViewController: viewController)
        navControlloer.modalPresentationStyle = .custom
        navControlloer.transitioningDelegate = presentationManager
        tabBarController?.present(navControlloer, animated: self.animatedTransitions, completion: nil)
    }
    
    private func pushTransactionCategoriesCollection(navigationController: UINavigationController, data: TransactionData) {
        let viewController: TransactionCategoriesCollectionViewController = storyboard.instantiate()
        viewController.presenter = Factory.categoriesListPresenter(userInterface: viewController, router: self)
        
        navigationController.pushViewController(viewController, animated: animatedTransitions)
    }
    
    private func settingsViewController() -> UIViewController {
        let viewController: SettingsViewController = storyboard.instantiate()
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "stats"), selectedImage: #imageLiteral(resourceName: "stats"))
        return navController
    }
}

extension RootFlowController: BudgetRoutingProtocol {
    
    func presentBudgetAmountEditor() {
        let viewController: SetupBudgetViewController = storyboard.instantiate()
        viewController.presenter = Factory.setupBudgetPresenter(routing: self, userInterface: viewController)
        tabBarController?.present(viewController, animated: animatedTransitions, completion: nil)
    }

    func dismissBudgetAmountEditor() {
        tabBarController?.dismiss(animated: animatedTransitions, completion: nil)
    }
}

extension RootFlowController: TransactionsSummaryRoutingProtocol {

    func presentDateRangePicker(presenter: DateRangePickerPresenterProtocol) {
        let actions = presenter.items.map { item -> UIAlertAction in
            let action = UIAlertAction(title: item.title, style: .default, handler: { action in
                presenter.select(item: item)
            })
            return action
        }
        
        let alertController = UIAlertController(title: "Pick date range",
                                                message: nil,
                                                preferredStyle: .actionSheet)
        actions.forEach { alertController.addAction($0) }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        tabBarController?.present(alertController, animated: animatedTransitions, completion: nil)
    }
}

extension RootFlowController: TransactionDataRouting {

    func showTransactionCategoriesPicker(transactionData: TransactionData) {
        
    }
    
}

extension RootFlowController: TransactionCategoriesListRouting {
    func categorySelected(_ transactionCategory: TransactionCategoryProtocol) {
        
    }
}
