//
//  TransactionCellViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 30.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

protocol TransactionCellViewModel {
    func amountText() -> String
    func descriptionText() -> String
}

class TransactionCellViewModelImplementation: TransactionCellViewModel {
    
    private let transaction: TransactionManagedObject
    
    init(transaction: TransactionManagedObject) {
        self.transaction = transaction
    }
    
    func amountText() -> String {
        return "-28291 $"
    }
    
    func descriptionText() -> String {
        return "20/01/2017 (obiad)"
    }
    
}
