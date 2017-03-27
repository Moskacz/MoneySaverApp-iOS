//
//  AppDelegate.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 19.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import RESTClient

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let navController = window?.rootViewController as? UINavigationController {
            if let transactionsListVC = navController.viewControllers.first as? TransactionsListViewController {
                let baseURL = URL(string: "http://localhost:3000")!
                let transactionsRestClient = RESTClientInterface(baseURL: baseURL).transactionsRESTClient()
                let transactionsModel = TransactionsModelImplementation(restClient: transactionsRestClient)
                transactionsListVC.viewModel = TransactionsListViewModel(transactionsModel: transactionsModel)
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

}

