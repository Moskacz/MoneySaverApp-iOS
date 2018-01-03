//
//  TransactionsSummaryElementViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.12.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

protocol TransactionsSummaryElementViewModel {
    var title: String? { get }
    var incomes: String? { get }
    var expenses: String? { get }
    var total: String? { get }
}

class TransactionsSummaryElementViewModelImpl: TransactionsSummaryElementViewModel {
    
    private let sum: TransactionsSum
    private let calendarService: CalendarService
    
    init(transactionsSum: TransactionsSum, calendarService: CalendarService) {
        self.sum = transactionsSum
        self.calendarService = calendarService
    }
    
    var title: String? {
        switch sum.dateComponent {
        case .day:
            return nil
        case .weekOfYear:
            return "This week"
        case .month:
            return calendarService.currentMonthDescription
        case .year:
            return calendarService.currentYearDescription
        case .dayOfYear:
            return "Today"
        }
    }
    
    var incomes: String? {
        return "+\(sum.incomes)"
    }
    
    var expenses: String? {
        return "\(sum.expenses)"
    }
    
    var total: String? {
        return "\(sum.total())"
    }
}
