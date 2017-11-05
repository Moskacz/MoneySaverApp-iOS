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
        tabBarVC.viewControllers = [transactionsListViewController(),
                                    budgetViewController(),
                                    statsViewController()]
        
        let navController = UINavigationController(rootViewController: tabBarVC)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navController
        applicationDelegate?.window = window
        applicationDelegate?.window?.makeKeyAndVisible()
        self.navigationController = navController
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
            self.navigationController?.dismiss(animated: self.animatedTransitions, completion: nil)
        }
        
        viewController.dataEnteredCallback = { [unowned viewController] (data: TransactionData) in
            guard let navController = viewController.navigationController else { return }
            self.pushTransactionCategoriesCollection(navigationController: navController, data: data)
        }
        
        let navControlloer = UINavigationController(rootViewController: viewController)
        navControlloer.modalPresentationStyle = .custom
        navControlloer.transitioningDelegate = presentationManager
        navigationController?.present(navControlloer, animated: self.animatedTransitions, completion: nil)
    }
    
    private func pushTransactionCategoriesCollection(navigationController: UINavigationController, data: TransactionData) {
        let viewController: TransactionCategoriesCollectionViewController = storyboard.instantiateFromStoryboard()
        viewController.viewModel = try! dependencyContainer.resolve()
        
        viewController.categorySelectedCallback = { category in
            self.transactionsService.addTransaction(data: data, category: category)
            self.navigationController?.dismiss(animated: self.animatedTransitions, completion: nil)
        }
        
        navigationController.pushViewController(viewController, animated: animatedTransitions)
    }
}
