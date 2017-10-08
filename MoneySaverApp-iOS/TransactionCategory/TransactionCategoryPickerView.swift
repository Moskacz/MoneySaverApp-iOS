//
//  TransactionCategoryPickerView.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 08.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionCategoryPickerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public var categorySelectedCallback = {}
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView()
        self.addSubview(collection)
        collection.matchParent()
        collection.register(cell: TransactionCategoryCollectionViewCell.self)
        return collection
    }()

    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension TransactionCategoryPickerView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TransactionCategoryCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
        return cell
    }
}

extension TransactionCategoryPickerView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categorySelectedCallback()
    }
}
