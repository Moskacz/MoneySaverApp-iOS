//
//  AppDelegate.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 19.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import RESTClient
import Dip

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dependencyContainer: DependencyContainer?
    var rootFlowController: FlowController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let diContainer = DependencyContainer.createContainer()
        rootFlowController = RootFlowController(applicationDelegate: self,
                                                storyboard: UIStoryboard.getMain(),
                                                dependencyContainer: diContainer)
        rootFlowController?.startFlow()
        dependencyContainer = diContainer
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

}

