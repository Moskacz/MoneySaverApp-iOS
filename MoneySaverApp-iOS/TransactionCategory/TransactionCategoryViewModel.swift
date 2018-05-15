//
//  TransactionCategoryViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 21.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore

protocol TransactionCategoryViewModel {
    var transactionName: String? { get }
    var transactionIcon: UIImage? { get }
}

class TransactionCategoryViewModelImpl: TransactionCategoryViewModel {
    
    private let category: TransactionCategoryProtocol
    
    init(category: TransactionCategoryProtocol) {
        self.category = category
    }
    
    var transactionName: String? {
        return category.name
    }
    
    var transactionIcon: UIImage? {
        return category.image
    }
}
