//
//  TransactionsDataWireframe.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09/12/2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore

internal class TransactionDataFlowController: FlowController {
    
    private let tabBarVC: UITabBarController
    private let storyboard: UIStoryboard
    private let presentationManager = CardStylePresentationManager()
    
    private var navController: UINavigationController?
    var animatedTransitions: Bool = true
    
    init(tabBarVC: UITabBarController, storyboard: UIStoryboard) {
        self.tabBarVC = tabBarVC
        self.storyboard = storyboard
    }
    
    func startFlow() {
        let viewController: TransactionDataViewController = storyboard.instantiate()
        viewController.presenter = Factory.transactionDataPresenter(userInterface: viewController,
                                                                    router: self)
        
        let navControlloer = TransactionDataNavigationController(rootViewController: viewController)
        navControlloer.modalPresentationStyle = .custom
        navControlloer.transitioningDelegate = presentationManager
        tabBarVC.present(navControlloer, animated: animatedTransitions, completion: nil)
        self.navController = navControlloer
    }
    
}

extension TransactionDataFlowController: TransactionDataRouting {
    
    func showTransactionCategoriesPicker(transactionData: TransactionData) {
        let viewController: TransactionCategoriesCollectionViewController = storyboard.instantiate()
        viewController.presenter = Factory.categoriesListPresenter(userInterface: viewController, router: self)
        navController!.pushViewController(viewController, animated: animatedTransitions)
    }
}

extension TransactionDataFlowController: TransactionCategoriesListRouting {
    
    func flowEnded() {
        
    }
}

