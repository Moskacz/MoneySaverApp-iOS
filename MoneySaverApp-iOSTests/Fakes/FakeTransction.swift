//
//  FakeTransction.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 04.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
@testable import MoneySaverApp_iOS

class FakeTransaction: TransactionProtocol {
    var title: String? = nil
    var value: NSDecimalNumber? = nil
    var transactionCategory: TransactionCategoryProtocol? = nil
    var transactionDate: CalendarDateProtocol? = nil
}
