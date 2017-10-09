//
//  TransactionCategoriesCollectionViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

class TransactionCategoriesCollectionViewModel {
    
    func numberOfItems() -> Int {
        return 50
    }
    
    func itemCellViewModel() -> TransactionCategoryCellViewModel {
        return TmpViewModel()
    }
}
