//
//  ChartsDataProcessor.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 22.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

struct PlotValue {
    let x: Int
    let y: Decimal
}

protocol ChartsDataProcessor {
    func spendings(fromMonthlyExpenses expenses: [DatedValue]) -> [PlotValue]
    func estimatedSpendings(budgetValue: Double) -> [PlotValue]
}

class ChartsDataProcessorImpl: ChartsDataProcessor {
    
    private let calendar: CalendarProtocol
    
    init(calendar: CalendarProtocol) {
        self.calendar = calendar
    }
    
    func spendings(fromMonthlyExpenses expenses: [DatedValue]) -> [PlotValue] {
        let sortedExpeneses = expenses.sorted { (lhs, rhs) -> Bool in
            return lhs.date < rhs.date
        }
        
        let daysRange = calendar.daysInMonthRange(forDate: calendar.now)
        return daysRange.map { day in
            let value = sortedExpeneses.reduce(0, { (sum, dailyValue) -> Decimal in
                guard dailyValue.date <= day else { return sum }
                return sum - dailyValue.value
            })
            return PlotValue(x: day, y: value)
        }
    }
    
    func estimatedSpendings(budgetValue: Double) -> [PlotValue] {
        let daysRange = calendar.daysInMonthRange(forDate: calendar.now)
        return daysRange.map { day in
            let dailySpending = budgetValue * Double(day)  / Double(daysRange.upperBound)
            return PlotValue(x: day, y: Decimal(floatLiteral: dailySpending))
        }
    }
    
}
