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
    private weak var tabBarController: UITabBarController?
    private let storyboard: UIStoryboard
    private let dependencyContainer: DependencyContainer
    private let transactionsService: TransactionsService
    private let presentationManager = CardStylePresentationManager()
    
    var animatedTransitions: Bool = true
    
    init(applicationDelegate: AppDelegate?,
         storyboard: UIStoryboard,
         dependencyContainer: DependencyContainer,
         transactionsService: TransactionsService) {
        self.applicationDelegate = applicationDelegate
        self.storyboard = storyboard
        self.dependencyContainer = dependencyContainer
        self.transactionsService = transactionsService
    }
    
    func startFlow() {
        setupRootFlowController()
    }
    
    private func setupRootFlowController() {
        let tabBarVC = DashboardTabBarController()
        let transactionsNavController = UINavigationController(rootViewController: transactionsListViewController())
        let budgetNavController = UINavigationController(rootViewController: budgetViewController())
        let statsNavController = UINavigationController(rootViewController: statsViewController())
        
        tabBarVC.viewControllers = [transactionsNavController,
                                    budgetNavController,
                                    statsNavController]
        tabBarVC.setupItemsTitles()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarVC
        applicationDelegate?.window = window
        applicationDelegate?.window?.makeKeyAndVisible()
        self.tabBarController = tabBarVC
    }
    
    private func transactionsListViewController() -> TransactionsListViewController {
        let viewController: TransactionsListViewController = storyboard.instantiateTypeViewController(withIdentifier: TransactionsListViewController.defaultStoryboardIdentifier)
        
        viewController.newTransactionButtonTapCallback = {
            self.presentTransactionDataViewController()
        }
        
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
    
    private func presentTransactionDataViewController() {
        let viewController: TransactionDataViewController = storyboard.instantiateFromStoryboard()
        viewController.viewModel = try! dependencyContainer.resolve()
        
        viewController.cancelButtonTapCallback = {
            self.tabBarController?.dismiss(animated: self.animatedTransitions, completion: nil)
        }
        
        viewController.dataEnteredCallback = { [unowned viewController] (data: TransactionData) in
            guard let navController = viewController.navigationController else { return }
            self.pushTransactionCategoriesCollection(navigationController: navController, data: data)
        }
        
        let navControlloer = UINavigationController(rootViewController: viewController)
        navControlloer.modalPresentationStyle = .custom
        navControlloer.transitioningDelegate = presentationManager
        tabBarController?.present(navControlloer, animated: self.animatedTransitions, completion: nil)
    }
    
    private func pushTransactionCategoriesCollection(navigationController: UINavigationController, data: TransactionData) {
        let viewController: TransactionCategoriesCollectionViewController = storyboard.instantiateFromStoryboard()
        viewController.viewModel = try! dependencyContainer.resolve()
        
        viewController.categorySelectedCallback = { category in
            self.transactionsService.addTransaction(data: data, category: category)
            self.tabBarController?.dismiss(animated: self.animatedTransitions, completion: nil)
        }
        
        navigationController.pushViewController(viewController, animated: animatedTransitions)
    }
}
