//
//  FakeCurrentDateProvider.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 04.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
@testable import MoneySaverApp_iOS

class FakeCurrentDateProvider: CurrentDateProvider {
    
    var date: Date!
    
    func currentDate() -> Date {
        return date
    }
}
