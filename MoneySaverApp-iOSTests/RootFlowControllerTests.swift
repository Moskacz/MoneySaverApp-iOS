//
//  RootFlowControllerTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 26.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import XCTest
import Dip
import MoneySaverAppCore
@testable import MoneySaverApp_iOS

class RootFlowControllerTests: XCTestCase {
    
    var appDelegate: AppDelegate!
    var sut: RootFlowController!
    
    override func setUp() {
        super.setUp()
        appDelegate = AppDelegate()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        sut = RootFlowController(applicationDelegate: appDelegate,
                                 storyboard: storyboard,
                                 dependencyContainer: DependencyContainer.createContainer())
    }
    
    override func tearDown() {
        sut = nil
        appDelegate = nil
        super.tearDown()
    }
    
    func test_whenFlowControllerStarted_thenShouldSetNavigationWithConfiguredTabBarAsRoot() {
        sut.startFlow()
        let tabBar = appDelegate.window!.rootViewController as! DashboardTabBarController
        XCTAssertTrue(tabBar.viewControllers![0] is TransactionsOverviewViewController)
        XCTAssertTrue(tabBar.viewControllers![1] is BudgetViewController)
        XCTAssertTrue(tabBar.viewControllers![3] is StatsViewController)
    }
    
    func test_whenAddNewButtonTapped_thenAddTransactionViewControllerEmbeddedInNavController_shouldBePresented() {
        sut.animatedTransitions = false
        sut.startFlow()
        let tabBar = appDelegate.window!.rootViewController as! DashboardTabBarController
        tabBar.centerButtonTapCallback()
        let presentedNavBar = tabBar.presentedViewController as! UINavigationController
        XCTAssert(presentedNavBar.viewControllers[0] is TransactionDataViewController)
    }
    
    func test_whenNextTappedOnTransactionDataVC_thenTransactionCategoryPickerShouldBePushed() {
        sut.animatedTransitions = false
        sut.startFlow()
        let tabBar = appDelegate.window!.rootViewController as! DashboardTabBarController
        tabBar.centerButtonTapCallback()
        let presentedNavBar = tabBar.presentedViewController as! UINavigationController
        let addTransactionVC = presentedNavBar.viewControllers[0] as! TransactionDataViewController
        addTransactionVC.dataEnteredCallback(TransactionData(title: "", value: Decimal(), creationDate: Date()))
        XCTAssert(presentedNavBar.viewControllers[1] is TransactionCategoriesCollectionViewController)
    }
    
}
