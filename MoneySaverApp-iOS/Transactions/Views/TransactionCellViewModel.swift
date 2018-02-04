//
//  TransactionCellViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 30.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

protocol TransactionCellViewModel {
    func titleText() -> String?
    func descriptionText() -> String?
    func categoryViewModel() -> TransactionCategoryViewModel?
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
    
    func categoryViewModel() -> TransactionCategoryViewModel? {
        guard let category = transaction.transactionCategory else { return nil }
        return TransactionCategorySimpleViewModelImpl(category: category)
    }
}
