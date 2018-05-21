//
//  FakeUserPreferences.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 08.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverAppCore

class FakeUserPreferences: UserPreferences {
    
    private var dateRangeStub: DateRange!
    private var statsGroupingStub: TransactionsGrouping!
    
    var dateRange: DateRange {
        get { return dateRangeStub }
        set { dateRangeStub = newValue }
    }
    
    var statsGrouping: TransactionsGrouping {
        get { return statsGroupingStub }
        set { statsGroupingStub = newValue }
    }
    
}
