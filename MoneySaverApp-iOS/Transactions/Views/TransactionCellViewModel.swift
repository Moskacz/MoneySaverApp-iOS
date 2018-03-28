//
//  TransactionCellViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 30.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MMFoundation

protocol TransactionCellViewModel {
    func titleText() -> String?
    func descriptionText() -> String?
    func categoryIcon() -> UIImage?
    func dateText() -> String?
    func indicatorGradient() -> Gradient?
}

class TransactionCellViewModelImplementation: TransactionCellViewModel {
    
    private let transaction: TransactionProtocol
    
    init(transaction: TransactionProtocol) {
        self.transaction = transaction
    }
    
    func titleText() -> String? {
        return transaction.value?.stringValue
    }
    
    func descriptionText() -> String? {
        return transaction.title
    }
    
    func dateText() -> String? {
        guard let timestamp = transaction.transactionDate?.timeInterval else { return nil }
        let date = Date(timeIntervalSince1970: timestamp)
        return DateFormatters.formatter(forType: .timeOnly).string(from: date)
    }
    
    func indicatorGradient() -> Gradient? {
        let value = transaction.value?.doubleValue ?? 0
        if value >= 0 {
            return Gradients.positiveValueTransaction
        } else {
            return Gradients.negativeValueTransaction
        }
    }
    
    func categoryIcon() -> UIImage? {
        return transaction.transactionCategory?.image
    }
}
