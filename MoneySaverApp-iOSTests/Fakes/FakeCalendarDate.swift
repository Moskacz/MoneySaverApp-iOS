//
//  FakeCalendarDate.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 05.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
@testable import MoneySaverApp_iOS

class FakeCalendarDate: CalendarDateProtocol {
    var calendarIdentifier: String? = nil
    var dayOfEra: Int32 = 0
    var dayOfMonth: Int32 = 0
    var dayOfYear: Int32 = 0
    var era: Int32 = 0
    var weekOfEra: Int32 = 0
    var weekOfMonth: Int32 = 0
    var weekOfYear: Int32 = 0
    var year: Int32 = 0
    var timeInterval: Double = 0
    var monthOfYear: Int32 = 0
    var monthOfEra: Int32 = 0
}
