//
//  TransactionDate.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

struct StructuredDate {
    let timeInterval: TimeInterval
    let dayOfWeek: Int
    let dayOfMonth: Int
    let dayOfYear: Int
    let dayOfEra: Int
    let weekOfMonth: Int
    let weekOfYear: Int
    let weekOfEra: Int
    let monthOfYear: Int
    let monthOfEra: Int
    let year: Int
    let era: Int
}

extension Calendar {
    func structuredDate(forDate date: Date) -> StructuredDate {
        return StructuredDate(timeInterval: date.timeIntervalSince1970,
                              dayOfWeek: component(.weekday, from: date),
                              dayOfMonth: component(.day, from: date),
                              dayOfYear: ordinality(of: .day, in: .year, for: date)!,
                              dayOfEra: ordinality(of: .day, in: .era, for: date)!,
                              weekOfMonth: component(.weekOfMonth, from: date),
                              weekOfYear: component(.weekOfYear, from: date),
                              weekOfEra: 1,
                              monthOfYear: component(.month, from: date),
                              monthOfEra: ordinality(of: .month, in: .era, for: date)!,
                              year: component(.year, from: date),
                              era: component(.era, from: date))
        
    }
}
