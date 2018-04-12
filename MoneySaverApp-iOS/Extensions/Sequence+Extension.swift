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
    
    var compoundSum: TransactionsCompoundSum {
        for transaction in self {
            transaction.transactionDate?.dayOfEra
        }
        
        return TransactionsCompoundSum(daily: .zero, weekly: .zero, monthly: .zero, yearly: .zero, era: .zero)
    }
    
    func compoundSum(date: CalendarDateProtocol) -> TransactionsCompoundSum {
        
        return TransactionsCompoundSum(daily: .zero, weekly: .zero, monthly: .zero, yearly: .zero, era: .zero)
    }
    
    
}
