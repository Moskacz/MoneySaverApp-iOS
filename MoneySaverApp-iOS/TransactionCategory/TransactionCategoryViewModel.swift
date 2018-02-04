//
//  TransactionCategoryViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 21.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

protocol TransactionCategoryViewModel {
    func transactionName() -> String?
    func transactionIcon() -> UIImage?
    func backgroundColor() -> UIColor?
}

class TransactionCategoryViewModelImpl: TransactionCategoryViewModel {
    
    private let category: TransactionCategoryProtocol
    
    init(category: TransactionCategoryProtocol) {
        self.category = category
    }
    
    func transactionName() -> String? {
        return category.name
    }
    
    func transactionIcon() -> UIImage? {
        return category.image
    }
    
    func backgroundColor() -> UIColor? {
        return category.categoryColor
    }
}

class TransactionCategorySimpleViewModelImpl: TransactionCategoryViewModelImpl {
    
    override func transactionName() -> String? {
        return nil
    }
}
