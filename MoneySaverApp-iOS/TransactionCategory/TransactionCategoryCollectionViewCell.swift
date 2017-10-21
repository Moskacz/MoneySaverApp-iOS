//
//  TransactionCategoryCollectionViewCell.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 08.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var transactionCategoryView: TransactionCategoryView?
    
    func update(withViewModel viewModel: TransactionCategoryViewModel) {
        transactionCategoryView?.update(withViewModel: viewModel)
    }
}


