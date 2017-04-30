//
//  TransactionCellViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 30.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

protocol TransactionCellViewModel {
    func amountText() -> String?
    func descriptionText() -> String?
    func backgroundColor() -> UIColor
}

class TransactionCellViewModelImplementation: TransactionCellViewModel {
    
    private let transaction: TransactionManagedObject
    
    init(transaction: TransactionManagedObject) {
        self.transaction = transaction
    }
    
    func amountText() -> String? {
        return transaction.value?.stringValue
    }
    
    func descriptionText() -> String? {
        return transaction.title
    }
    
    func backgroundColor() -> UIColor {
        let value = transaction.value?.doubleValue ?? 0.0
        return value > 0 ? Theme.greenColor : Theme.redColor
    }
    
}
