//
//  StructuredDateBuilder.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 14.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
@testable import MoneySaverApp_iOS

class StructuredDateBuilder {
    
    private var timeInterval: TimeInterval = 0
    private var dayOfWeek = 0
    private var dayOfMonth = 0
    private var dayOfYear = 0
    private var dayOfEra = 0
    private var weekOfMonth = 0
    private var weekOfYear = 0
    private var weekOfEra = 0
    private var monthOfYear = 0
    private var monthOfEra = 0
    private var year = 0
    private var era = 0
    
    
    
    func build() -> StructuredDate {
        return StructuredDate(timeInterval: timeInterval,
                              dayOfWeek: dayOfWeek,
                              dayOfMonth: dayOfMonth,
                              dayOfYear: dayOfYear,
                              dayOfEra: dayOfEra,
                              weekOfMonth: weekOfMonth,
                              weekOfYear: weekOfYear,
                              weekOfEra: weekOfEra,
                              monthOfYear: monthOfYear,
                              monthOfEra: monthOfEra,
                              year: year,
                              era: era)
    }
}
