//
//  AppDelegate.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 19.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import Dip
import MoneySaverAppCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootFlowController: RootFlowController?
    var coreDataStack: CoreDataStack?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let diContainer = DependencyContainer.createContainer()
        let stack: CoreDataStack = try! diContainer.resolve()
        diContainer.register {
            stack.getViewContext()
        }
        
        rootFlowController = RootFlowController(applicationDelegate: self,
                                                storyboard: UIStoryboard.getMain(),
                                                dependencyContainer: diContainer)
        rootFlowController?.startFlow()
        coreDataStack = stack
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveCoreData()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {
        saveCoreData()
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        rootFlowController?.setup(flowState: .transactionData)
        completionHandler(true)
    }
    
    private func saveCoreData() {
        do {
            try coreDataStack?.save()
        } catch {
            print(error)
        }
    }

}

