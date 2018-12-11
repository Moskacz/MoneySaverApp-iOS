//
//  AppDelegate.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 19.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootFlowController: RootFlowController?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureFactory()
        rootFlowController = RootFlowController(applicationDelegate: self,
                                                storyboard: UIStoryboard.getMain())
        rootFlowController?.startFlow()
        return true
    }
    
    private func configureFactory() {
        let storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: AppGroup.group.identifier)!.appendingPathComponent("Database.sqlite")
        Factory.databaseURL = storeURL
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        rootFlowController?.setup(flowState: .transactionData)
        completionHandler(true)
    }
}

