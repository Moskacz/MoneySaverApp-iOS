//
//  FakeTransactionsComputingService.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 15.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import MMFoundation
@testable import MoneySaverApp_iOS

class FakeTransactionsComputingService: TransactionsComputingService {
    
    var delegates: WeakArray<AnyObject> {
        fatalError()
    }
    
    func sum() -> TransactionsCompoundSum {
        fatalError()
    }
    
    func monthlyExpenses() -> [DailyValue] {
        fatalError()
    }
}
