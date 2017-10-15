//
//  TransactionCategoryCollectionViewCell.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 08.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionCategoryCellViewModelImpl: TransactionCategoryViewModel {
    
    private let category: TransactionCategoryManagedObject
    
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
}

class TransactionCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var transactionCategoryView: TransactionCategoryView?
    
    func update(withViewModel viewModel: TransactionCategoryViewModel) {
        transactionCategoryView?.update(withViewModel: viewModel)
    }
}


