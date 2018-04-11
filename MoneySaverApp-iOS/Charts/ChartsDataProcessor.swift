//
//  ChartsDataProcessor.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 22.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation



protocol ChartsDataProcessor {
    func spendings(fromMonthlyExpenses expenses: [DatedValue]) -> [DatedValue]
    func estimatedSpendings(budgetValue: Double) -> [DatedValue]
}

class ChartsDataProcessorImpl: ChartsDataProcessor {
    
    private let calendar: CalendarProtocol
    
    init(calendar: CalendarProtocol) {
        self.calendar = calendar
    }
    
    func spendings(fromMonthlyExpenses expenses: [DatedValue]) -> [DatedValue] {
        let sortedExpeneses = expenses.sorted { (lhs, rhs) -> Bool in
            return lhs.date < rhs.date
        }
        
        let daysRange = calendar.daysInMonthRange(forDate: calendar.now)
        return daysRange.map { day in
            let value = sortedExpeneses.reduce(0, { (sum, dailyValue) -> Decimal in
                guard dailyValue.date <= day else { return sum }
                return sum - dailyValue.value
            })
            return DatedValue(date: day, value: value)
        }
    }
    
    func estimatedSpendings(budgetValue: Double) -> [DatedValue] {
        let daysRange = calendar.daysInMonthRange(forDate: calendar.now)
        return daysRange.map { day in
            let dailySpending = budgetValue * Double(day)  / Double(daysRange.upperBound)
            return DatedValue(date: day, value: Decimal(floatLiteral: dailySpending))
        }
    }
    
}
