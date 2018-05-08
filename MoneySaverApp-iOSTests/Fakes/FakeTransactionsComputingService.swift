//
//  FakeTransactionsComputingService.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 15.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import MMFoundation
import MoneySaverAppCore
@testable import MoneySaverApp_iOS

class FakeTransactionsComputingService: TransactionsComputingService {
    
    func sum() -> TransactionsCompoundSum {
        fatalError()
    }
    
    func observeTransactionsSumChanged(_ callback: @escaping (TransactionsCompoundSum) -> Void) -> ObservationToken {
        fatalError()
    }
    
    func monthlyExpenses() -> [DatedValue] {
        fatalError()
    }
    
    func observeMonthlyExpenseChanged(_ callback: @escaping ([DatedValue]) -> Void) -> ObservationToken {
        fatalError()
    }
}
