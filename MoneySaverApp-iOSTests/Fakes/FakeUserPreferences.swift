//
//  FakeUserPreferences.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 08.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
@testable import MoneySaverApp_iOS

class FakeUserPreferences: UserPreferences {
    
    var dateRangeStub: DateRange!
    
    var dateRange: DateRange {
        get { return dateRangeStub }
        set { dateRangeStub = newValue }
    }
    
}
