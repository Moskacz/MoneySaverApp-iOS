//
//  FakeAppPreservationModel.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 16.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
@testable import MoneySaverApp_iOS

class FakeAppPreservationModel: AppPreservationModel {
    
    var saveFilerCalled = false
    var savedFilterToReturn: DateRange? = nil
    
    func save(dateRangeFilter filter: DateRange) {
        saveFilerCalled = true
    }
    
    var savedDateRangeFilter: DateRange? {
        return savedFilterToReturn
    }
    
}
