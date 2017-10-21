//
//  TransactionCategoryCollectionViewCell.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 08.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

protocol TransactionCategoryCellViewModel: TransactionCategoryViewModel {
    var category: TransactionCategoryManagedObject { get }
}

class TransactionCategoryCellViewModelImpl: TransactionCategoryCellViewModel {
    
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
        let r = CGFloat(category.backgroundColorRedComponent)
        let g = CGFloat(category.backgroundColorGreenComponent)
        let b = CGFloat(category.backgroundColorBlueComponent)
        let a = CGFloat(category.backgroundColorAlphaComponent)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

class TransactionCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var transactionCategoryView: TransactionCategoryView?
    
    func update(withViewModel viewModel: TransactionCategoryViewModel) {
        transactionCategoryView?.update(withViewModel: viewModel)
    }
}


