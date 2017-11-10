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
    private weak var tabBarController: DashboardTabBarController?
    private weak var transactionsVC: TransactionsListViewController?
    private let storyboard: UIStoryboard
    private let dependencyContainer: DependencyContainer
    private let presentationManager = CardStylePresentationManager()
    
    var animatedTransitions: Bool = true
    
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
        let stack: CoreDataStack = try! dependencyContainer.resolve()
        stack.loadStores { [unowned stack, weak self] in
            self?.dependencyContainer.register {
                stack.getViewContext()
            }
            self?.setupViewModels(stack: stack)
        }
        
        let tabBarVC = DashboardTabBarController()
        
        let transactionsListVC = transactionsListViewController()
        self.transactionsVC = transactionsListVC
        let transactionsNavController = UINavigationController(rootViewController: transactionsListVC)
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
        setupViewModels(stack: stack)
    }
    
    private func transactionsListViewController() -> TransactionsListViewController {
        let viewController: TransactionsListViewController = storyboard.instantiateTypeViewController(withIdentifier: TransactionsListViewController.defaultStoryboardIdentifier)
        
        viewController.newTransactionButtonTapCallback = {
            self.presentTransactionDataViewController()
        }
        
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
    
    private func setupViewModels(stack: CoreDataStack) {
        guard stack.isLoaded else { return }
        
        if transactionsVC?.viewModel == nil {
            transactionsVC?.viewModel = try! dependencyContainer.resolve()
        }
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
//            self.transactionsService.addTransaction(data: data, category: category)
            self.tabBarController?.dismiss(animated: self.animatedTransitions, completion: nil)
        }
        
        navigationController.pushViewController(viewController, animated: animatedTransitions)
    }
}
