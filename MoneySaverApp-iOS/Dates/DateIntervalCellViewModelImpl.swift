//
//  DateIntervalCellViewModelImpl.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

class DateIntervalCellViewModelImpl: DateIntervalCellViewModel {
    
    private let sum: TransactionsSum
    private let calendarService: CalendarService
    
    init(sum: TransactionsSum, calendarService: CalendarService) {
        self.sum = sum
        self.calendarService = calendarService
    }
    
    func intervalTitle() -> String? {
        switch sum.dateComponent {
        case .day:
            return "Today"
        case .weekOfYear:
            return "This week"
        case .month:
            let value = calendarService.component(sum.dateComponent, ofDate: Date())
            return calendarService.monthSymbols[value]
        case .year:
            return "\(calendarService.component(sum.dateComponent, ofDate: Date()))"
        case .dayOfYear:
            return nil
        }
    }
    
    func incomesSum() -> String? {
        return "+\(sum.incomes)"
    }
    
    func expensesSum() -> String? {
        return "\(sum.expenses)"
    }
    
    func totalSum() -> String? {
        return "\(sum.total())"
    }
    
}
