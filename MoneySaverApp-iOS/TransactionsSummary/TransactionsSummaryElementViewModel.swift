//
//  TransactionsSummaryElementViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.12.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

protocol TransactionsSummaryElementViewModel {
    var dateComponent: TransactionDateComponent { get }
    var title: String? { get }
    var incomes: String? { get }
    var expenses: String? { get }
    var total: String? { get }
}

class TransactionsSummaryElementViewModelImpl: TransactionsSummaryElementViewModel {
    
    private let sum: TransactionsSum
    
    init(transactionsSum: TransactionsSum) {
        self.sum = transactionsSum
    }
    
    var dateComponent: TransactionDateComponent {
        return sum.dateComponent
    }
    
    var title: String? {
        return nil
    }
    
    var incomes: String? {
        return "\(sum.incomes)"
    }
    
    var expenses: String? {
        return "\(sum.expenses)"
    }
    
    var total: String? {
        return "\(sum.total())"
    }
}
