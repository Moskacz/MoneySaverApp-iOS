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
    
    init(applicationDelegate: AppDelegate?, storyboard: UIStoryboard, dependencyContainer: DependencyContainer) {
        self.applicationDelegate = applicationDelegate
        self.storyboard = storyboard
        self.dependencyContainer = dependencyContainer
    }
    
    func startFlow() {
        setupRootFlowController()
    }
    
    private func setupRootFlowController() {
        let tabBarVC: DashboardTabBarController = storyboard.instantiateTypeViewController(withIdentifier: DashboardTabBarController.storyboardId)
        
        if let viewControllers = tabBarVC.viewControllers {
            for viewController in viewControllers {
                if let transactionsListVC = viewController as? TransactionsListViewController {
                    configure(transactionsListViewController: transactionsListVC)
                }
            }
        }
        
        let navController = UINavigationController(rootViewController: tabBarVC)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navController
        applicationDelegate?.window = window
        applicationDelegate?.window?.makeKeyAndVisible()
        self.navigationController = navController
    }
    
    private func configure(transactionsListViewController viewController: TransactionsListViewController) {
        viewController.addTransactionTapCallback = {
            self.presendAddTransactionViewController()
        }
        viewController.viewModel = try! dependencyContainer.resolve()
    }
    
    private func presendAddTransactionViewController() {
        let viewController: AddTransactionViewController = storyboard.instantiateTypeViewController(withIdentifier: AddTransactionViewController.storyboardId)
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
