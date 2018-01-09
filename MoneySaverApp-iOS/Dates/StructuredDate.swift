//
//  TransactionDate.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

struct StructuredDate {
    let dayOfWeek: Int
    let dayOfMonth: Int
    let dayOfYear: Int
    let dayOfEra: Int
    let weekOfYear: Int
    let month: Int
    let year: Int
    let era: Int
}

extension Calendar {
    func structuredDate(forDate date: Date) -> StructuredDate {
        return StructuredDate(dayOfWeek: component(.weekday, from: date),
                              dayOfMonth: component(.day, from: date),
                              dayOfYear: ordinality(of: .day, in: .year, for: date)!,
                              dayOfEra: ordinality(of: .day, in: .era, for: date)!,
                              weekOfYear: component(.weekOfYear, from: date),
                              month: component(.month, from: date),
                              year: component(.year, from: date),
                              era: component(.era, from: date))
        
    }
}
