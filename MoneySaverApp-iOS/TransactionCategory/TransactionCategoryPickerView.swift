//
//  TransactionCategoryPickerView.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 08.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionCategoryPickerView: UIView {
    
    public var categorySelectedCallback = {}
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView()
        self.addSubview(collection)
        collection.matchParent()
        collection.register(cell: TransactionCategoryCollectionViewCell.self)
        return collection
    }()
    
    var viewModel: TransactionCategoryPickerViewModel? {
        didSet {
            setup()
        }
    }

    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension TransactionCategoryPickerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = viewModel else { return 0 }
        return model.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = viewModel else { fatalError("should not happen") }
        let cell: TransactionCategoryCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
        cell.update(viewModel: model.itemCellViewModel())
        return cell
    }
}

extension TransactionCategoryPickerView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categorySelectedCallback()
    }
}
