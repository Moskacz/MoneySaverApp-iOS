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
        let transactionsListVC: TransactionsListViewController = storyboard.instantiateTypeViewController(withIdentifier: TransactionsListViewController.storyboardId)
        transactionsListVC.addTransactionTapCallback = {
            self.pushAddTransactionViewController()
        }
        transactionsListVC.viewModel = try! dependencyContainer.resolve()
        
        let navController = UINavigationController(rootViewController: transactionsListVC)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navController
        applicationDelegate?.window = window
        applicationDelegate?.window?.makeKeyAndVisible()
        self.navigationController = navController
    }
    
    private func pushAddTransactionViewController() {
        let viewController: AddTransactionViewController = storyboard.instantiateTypeViewController(withIdentifier: AddTransactionViewController.storyboardId)
        viewController.transactionAddedCallback = {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
