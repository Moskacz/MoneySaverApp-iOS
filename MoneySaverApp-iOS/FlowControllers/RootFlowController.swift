//
//  RootFlowController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 05.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class RootFlowController: FlowController {
    
    private weak var applicationDelegate: AppDelegate?
    private let storyboard: UIStoryboard
    
    init(applicationDelegate: AppDelegate?, storyboard: UIStoryboard) {
        self.applicationDelegate = applicationDelegate
        self.storyboard = storyboard
    }
    
    func startFlow() {
        setupRootFlowController()
    }
    
    private func setupRootFlowController() {
        let transactionsListVC: TransactionsListViewController = storyboard.instantiateTypeViewController(withIdentifier: TransactionsListViewController.storyboardId)
        let navController = UINavigationController(rootViewController: transactionsListVC)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navController
        applicationDelegate?.window = window
        applicationDelegate?.window?.makeKeyAndVisible()
    }
}
