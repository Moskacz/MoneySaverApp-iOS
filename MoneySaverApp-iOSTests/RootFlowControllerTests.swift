//
//  RootFlowControllerTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 26.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import XCTest
import Dip
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
                                 dependencyContainer: DependencyContainer.createContainer(),
                                 transactionsService: FakeTransactionsService())
    }
    
    override func tearDown() {
        sut = nil
        appDelegate = nil
        super.tearDown()
    }
    
    func test_whenFlowControllerStarted_thenShouldSetNavigationWithConfiguredTabBarAsRoot() {
        sut.startFlow()
        let navController = appDelegate.window!.rootViewController as! UINavigationController
        let tabBar = navController.viewControllers.first as! DashboardTabBarController
        XCTAssertTrue(tabBar.viewControllers![0] is TransactionsListViewController)
        XCTAssertTrue(tabBar.viewControllers![1] is BudgetViewController)
        XCTAssertTrue(tabBar.viewControllers![2] is StatsViewController)
    }
    
    func test_whenAddNewButtonTapped_thenAddTransactionViewControllerEmbeddedInNavController_shouldBePresented() {
        sut.animatedTransitions = false
        sut.startFlow()
        let navBar = appDelegate.window!.rootViewController as! UINavigationController
        let tabBar = navBar.viewControllers.first as! DashboardTabBarController
        tabBar.newTransactionButtonTapCallback()
        let presentedNavBar = navBar.presentedViewController as! UINavigationController
        XCTAssert(presentedNavBar.viewControllers[0] is TransactionDataViewController)
    }
    
    func test_whenNextTappedOnTransactionDataVC_thenTransactionCategoryPickerShouldBePushed() {
        sut.animatedTransitions = false
        sut.startFlow()
        let navBar = appDelegate.window!.rootViewController as! UINavigationController
        let tabBar = navBar.viewControllers.first as! DashboardTabBarController
        tabBar.newTransactionButtonTapCallback()
        let presentedNavBar = navBar.presentedViewController as! UINavigationController
        let addTransactionVC = presentedNavBar.viewControllers[0] as! TransactionDataViewController
        addTransactionVC.dataEnteredCallback(TransactionData(title: "", value: Decimal()))
        XCTAssert(presentedNavBar.viewControllers[1] is TransactionCategoriesCollectionViewController)
    }
    
    func test_whenUserCancelsAddingNewTransaction_thenAddTransactionVCShouldBeDismissed() {
        sut.animatedTransitions = false
        sut.startFlow()
        let navBar = appDelegate.window!.rootViewController as! UINavigationController
        let tabBar = navBar.viewControllers.first as! DashboardTabBarController
        tabBar.newTransactionButtonTapCallback()
        let presentedNavBar = navBar.presentedViewController as! UINavigationController
        let addTransactionVC = presentedNavBar.viewControllers[0] as! TransactionDataViewController
        addTransactionVC.cancelButtonTapped()
        expectation(for: NSPredicate(format: "presentedViewController == nil"), evaluatedWith: navBar, handler: nil)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
