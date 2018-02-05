//
//  CalendarDateProtocol.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 05.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

protocol CalendarDateProtocol {
    var calendarIdentifier: String? { get }
    var dayOfEra: Int32 { get }
    var dayOfMonth: Int32 { get }
    var dayOfYear: Int32 { get }
    var era: Int32 { get }
    var weekOfEra: Int32 { get }
    var weekOfMonth: Int32 { get }
    var weekOfYear: Int32 { get }
    var year: Int32 { get }
    var timeInterval: Double { get }
    var monthOfYear: Int32 { get }
    var monthOfEra: Int32 { get }
}
