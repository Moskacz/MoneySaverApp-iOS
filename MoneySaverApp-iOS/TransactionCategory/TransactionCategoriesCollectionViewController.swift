//
//  TransactionCategoriesCollectionViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionCategoriesCollectionViewController: UICollectionViewController {
    
    var viewModel: TransactionCategoriesCollectionViewModel?
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        guard let model = viewModel else { return 0 }
        return model.numberOfItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = viewModel else { fatalError("should not happen") }
        let cell: TransactionCategoryCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
        cell.update(viewModel: model.itemCellViewModel(forIndexPath: indexPath))
        return cell
    }
    
    
}
