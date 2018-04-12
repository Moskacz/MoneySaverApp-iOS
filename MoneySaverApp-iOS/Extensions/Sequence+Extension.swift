//
//  Sequence+Extension.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 30.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

extension Sequence {
    
    func grouped<U>(by key: (Element) -> U) -> [U: [Element]] {
        var dict = [U: [Element]]()
        for element in self {
            let key = key(element)
            var array = dict[key] ?? []
            array.append(element)
            dict[key] = array
        }
        return dict
    }
    
}

extension Sequence where Element: TransactionProtocol {
    
    func compoundSum(date: CalendarDateProtocol) -> TransactionsCompoundSum {
        var day = [Element]()
        var week = [Element]()
        var month = [Element]()
        var year = [Element]()
        
        for element in self {
            if element.transactionDate?.dayOfEra == date.dayOfEra {
                day.append(element)
            }
            if element.transactionDate?.weekOfEra == date.weekOfEra {
                week.append(element)
            }
            if element.transactionDate?.monthOfEra == date.monthOfEra {
                month.append(element)
            }
            if element.transactionDate?.year == date.year {
                year.append(element)
            }
        }
        
        return TransactionsCompoundSum(daily: day.transactionsSum,
                                       weekly: week.transactionsSum,
                                       monthly: month.transactionsSum,
                                       yearly: year.transactionsSum,
                                       era: self.transactionsSum)
    }
    
    var transactionsSum: TransactionsSum {
        let incomes = map { $0.value?.doubleValue ?? 0 }.filter { $0 > 0 }.reduce(0, +)
        let expenses = map { $0.value?.doubleValue ?? 0 }.filter { $0 < 0 }.reduce(0, +)
        
        return TransactionsSum(incomes: Decimal(incomes), expenses: Decimal(expenses))
    }
}
