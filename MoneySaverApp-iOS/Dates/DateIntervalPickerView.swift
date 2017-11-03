//
//  DateIntervalPickerView.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 03.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class DateIntervalPickerView: UIView {
    
    @IBOutlet private weak var dateIntervalsCollectionView: UICollectionView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        dateIntervalsCollectionView?.register(cell: DateIntervalCell.self)
        dateIntervalsCollectionView?.reloadData()
    }
}

extension DateIntervalPickerView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DateIntervalCell = collectionView.dequeueCell(forIndexPath: indexPath)
        return cell
    }
}

extension DateIntervalPickerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.height
        return CGSize(width: size, height: size)
    }
}

