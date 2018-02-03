//
//  RootFlowController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 05.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import Dip

enum FlowState {
    case transactionsList
    case budget
    case transactionData
}

class RootFlowController: FlowController {
    
    private weak var applicationDelegate: AppDelegate?
    private weak var tabBarController: DashboardTabBarController?
    private weak var transactionsVC: TransactionsListViewController?
    private weak var budgetVC: BudgetViewController?
    private weak var statsVC: StatsViewController?
    
    private let storyboard: UIStoryboard
    private let dependencyContainer: DependencyContainer
    private let presentationManager = CardStylePresentationManager()
    
    var animatedTransitions: Bool = true
    
    private lazy var flowService: RootFlowService? = {
       return try? self.dependencyContainer.resolve()
    }()
    
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
        let stack: CoreDataStack = try! dependencyContainer.resolve()
        stack.loadStores { [unowned stack, weak self] in
            self?.dependencyContainer.register {
                stack.getViewContext()
            }
            self?.setupViewModels(stack: stack)
        }
        
        let tabBarVC = DashboardTabBarController()
        
        let transactionsListVC = transactionsListViewController()
        let budgetVC = budgetViewController()
        let budgetNavController = UINavigationController(rootViewController: budgetVC)
        
        tabBarVC.viewControllers = [transactionsListVC,
                                    budgetNavController,
                                    UIViewController(),
                                    statsViewController(),
                                    SettingsViewController()]
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarVC
        applicationDelegate?.window = window
        applicationDelegate?.window?.makeKeyAndVisible()
        self.tabBarController = tabBarVC
        setupViewModels(stack: stack)
        
        tabBarVC.centerButtonTapCallback = {
            self.presentTransactionDataViewController()
        }
    }
    
    private func transactionsListViewController() -> TransactionsListViewController {
        let viewController: TransactionsListViewController = storyboard.instantiateTypeViewController(withIdentifier: TransactionsListViewController.defaultStoryboardIdentifier)
        
        viewController.newTransactionButtonTapCallback = {
            self.presentTransactionDataViewController()
        }
        
        self.transactionsVC = viewController
        return viewController
    }
    
    private func budgetViewController() -> BudgetViewController {
        let viewController: BudgetViewController = storyboard.instantiateTypeViewController(withIdentifier: BudgetViewController.defaultStoryboardIdentifier)
        
        viewController.editBudgetTapCallback = {
            self.presentSetupBudgetViewController()
        }
        
        self.budgetVC = viewController
        return viewController
    }
    
    private func statsViewController() -> StatsViewController {
        let viewController: StatsViewController = storyboard.instantiateTypeViewController(withIdentifier: StatsViewController.defaultStoryboardIdentifier)
        self.statsVC = viewController
        return viewController
    }
    
    private func setupViewModels(stack: CoreDataStack) {
        guard stack.isLoaded else { return }
        
        if transactionsVC?.viewModel == nil {
            transactionsVC?.viewModel = try! dependencyContainer.resolve()
        }
        
        if budgetVC?.viewModel == nil {
            budgetVC?.viewModel = try! dependencyContainer.resolve()
        }
        
        if budgetVC?.setupBudgetViewModel == nil {
            budgetVC?.setupBudgetViewModel = try! dependencyContainer.resolve()
        }
        
        if statsVC?.viewModel == nil {
            statsVC?.viewModel = try! dependencyContainer.resolve()
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
            self.flowService?.addTransaction(withData: data, category: category)
            self.tabBarController?.dismiss(animated: self.animatedTransitions, completion: nil)
        }
        
        navigationController.pushViewController(viewController, animated: animatedTransitions)
    }
    
    private func presentSetupBudgetViewController() {
        let viewController: SetupBudgetViewController = storyboard.instantiateFromStoryboard()
        viewController.viewModel = try! dependencyContainer.resolve()
        
        viewController.budgetSetCallback = {
            self.tabBarController?.dismiss(animated: self.animatedTransitions, completion: nil)
        }
        
        viewController.closeButtonCallback = {
            self.tabBarController?.dismiss(animated: self.animatedTransitions, completion: nil)
        }
        
        tabBarController?.present(viewController, animated: animatedTransitions, completion: nil)
    }
}
