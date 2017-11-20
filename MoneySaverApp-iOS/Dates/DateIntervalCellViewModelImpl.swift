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
    
    init(sum: TransactionsSum) {
        self.sum = sum
    }
    
    func intervalTitle() -> String? {
        switch sum.dateComponent {
        case .day:
            return "Today"
        case .weekOfYear:
            return "This week"
        case .month:
            return "This month"
        case .year:
            return "This year"
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
