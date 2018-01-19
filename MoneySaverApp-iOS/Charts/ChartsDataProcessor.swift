//
//  ChartsDataProcessor.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 22.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

protocol ChartsDataProcessor {
    func spendings(fromMonthlyExpenses expenses: [DailyValue]) -> [DailyValue]
    func estimatedSpendings(budgetValue: Double) -> [DailyValue]
}

class ChartsDataProcessorImpl: ChartsDataProcessor {
    
    private let calendar: CalendarProtocol
    
    init(calendar: CalendarProtocol) {
        self.calendar = calendar
    }
    
    func spendings(fromMonthlyExpenses expenses: [DailyValue]) -> [DailyValue] {
        let sortedExpeneses = expenses.sorted { (lhs, rhs) -> Bool in
            return lhs.day < rhs.day
        }
        
        let daysRange = calendar.daysInMonthRange(forDate: calendar.now)
        return daysRange.map { day in
            let value = sortedExpeneses.reduce(0, { (sum, dailyValue) -> Decimal in
                guard dailyValue.day <= day else { return sum }
                return sum - dailyValue.value
            })
            return DailyValue(day: day, value: value)
        }
    }
    
    func estimatedSpendings(budgetValue: Double) -> [DailyValue] {
        let daysRange = calendar.daysInMonthRange(forDate: calendar.now)
        return daysRange.map { day in
            let dailySpending = budgetValue * Double(day)  / Double(daysRange.upperBound)
            return DailyValue(day: day, value: Decimal(floatLiteral: dailySpending))
        }
    }
    
}
