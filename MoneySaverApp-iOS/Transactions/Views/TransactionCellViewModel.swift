//
//  TransactionCellViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 30.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverFoundationiOS

protocol TransactionCellViewModel {
    func amountText() -> String
    func descriptionText() -> String
    func tintColor() -> UIColor
}

class TransactionCellViewModelImplementation: TransactionCellViewModel {
    
    private let transaction: TransactionManagedObject
    
    init(transaction: TransactionManagedObject) {
        self.transaction = transaction
    }
    
    func amountText() -> String {
        return transaction.value.stringValue
    }
    
    func descriptionText() -> String {
        return transaction.title
    }
    
    func tintColor() -> UIColor {
        let value = transaction.value.doubleValue
        return value > 0 ? Theme.greenColor : Theme.redColor
    }
    
}
