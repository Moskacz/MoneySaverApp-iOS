//
//  TransactionCategoryPickerViewModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 08.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TmpViewModel: TransactionCategoryCellViewModel {
    func categoryName() -> String? {
        return "test"
    }
    
    func categoryIcon() -> UIImage? {
        return nil
    }
    
    func backgroundColor() -> UIColor? {
        return UIColor.orange
    }
}

class TransactionCategoryPickerViewModel {
    
    func numberOfItems() -> Int {
        return 5
    }
    
    func itemCellViewModel() -> TransactionCategoryCellViewModel {
        return TmpViewModel()
    }
}
