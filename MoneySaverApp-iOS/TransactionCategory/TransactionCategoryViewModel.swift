//
//  TransactionCategoryViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 21.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

protocol TransactionCategoryViewModel {
    var category: TransactionCategoryManagedObject { get }
    func transactionName() -> String?
    func transactionIcon() -> UIImage?
    func backgroundColor() -> UIColor?
}

class TransactionCategoryViewModelImpl: TransactionCategoryViewModel {
    
    let category: TransactionCategoryManagedObject
    
    init(category: TransactionCategoryManagedObject) {
        self.category = category
    }
    
    func transactionName() -> String? {
        return category.name
    }
    
    func transactionIcon() -> UIImage? {
        guard let imageData = category.icon else { return nil }
        return UIImage(data: imageData as Data)
    }
    
    func backgroundColor() -> UIColor? {
        return UIColor.orange
    }
}
