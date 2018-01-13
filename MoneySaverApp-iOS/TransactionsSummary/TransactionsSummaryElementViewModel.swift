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
    private let calendar: CalendarProtocol
    
    init(transactionsSum: TransactionsSum, calendar: CalendarProtocol) {
        self.sum = transactionsSum
        self.calendar = calendar
    }
    
    var title: String? {
        switch sum.dateRange {
        case .today:
            return "Today"
        case .thisWeek:
            return "Week"
        case .thisMonth:
            return calendar.monthName(forDate: calendar.now)
        case .thisYear:
            return calendar.yearName(forDate: calendar.now)
        case .allTime:
            return "Overall"
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
