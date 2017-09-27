//
//  RootFlowController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 05.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import Dip

class RootFlowController: FlowController {
    
    private weak var applicationDelegate: AppDelegate?
    private weak var navigationController: UINavigationController?
    private let storyboard: UIStoryboard
    private let dependencyContainer: DependencyContainer
    
    init(applicationDelegate: AppDelegate?,
         storyboard: UIStoryboard,
         dependencyContainer: DependencyContainer) {
        self.applicationDelegate = applicationDelegate
        self.storyboard = storyboard
        self.dependencyContainer = dependencyContainer
    }
    
    func startFlow() {
        setupRootFlowController()
    }
    
    private func setupRootFlowController() {
        let tabBarVC = DashboardTabBarController()
        tabBarVC.viewControllers = [transactionsListViewController(),
                                    budgetViewController(),
                                    statsViewController()]
        
        tabBarVC.newTransactionButtonTapCallback = {
            self.presendAddTransactionViewController()
        }
        
        let navController = UINavigationController(rootViewController: tabBarVC)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navController
        applicationDelegate?.window = window
        applicationDelegate?.window?.makeKeyAndVisible()
        self.navigationController = navController
    }
    
    private func transactionsListViewController() -> TransactionsListViewController {
        let viewController: TransactionsListViewController = storyboard.instantiateTypeViewController(withIdentifier: TransactionsListViewController.defaultStoryboardIdentifier)
        
        viewController.viewModel = try! dependencyContainer.resolve()
        return viewController
    }
    
    private func budgetViewController() -> BudgetViewController {
        let viewController: BudgetViewController = storyboard.instantiateTypeViewController(withIdentifier: BudgetViewController.defaultStoryboardIdentifier)
        return viewController
    }
    
    private func statsViewController() -> StatsViewController {
        let viewController: StatsViewController = storyboard.instantiateTypeViewController(withIdentifier: StatsViewController.defaultStoryboardIdentifier)
        return viewController
    }
    
    private func presendAddTransactionViewController() {
        let viewController: AddTransactionViewController = storyboard.instantiateTypeViewController(withIdentifier: AddTransactionViewController.defaultStoryboardIdentifier)
        viewController.viewModel = try! dependencyContainer.resolve()
        
        viewController.cancelButtonTapCallback = {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        
        viewController.transactionAddedCallback = {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        
        let navControlloer = UINavigationController(rootViewController: viewController)
        navigationController?.present(navControlloer, animated: true, completion: nil)
    }
}
