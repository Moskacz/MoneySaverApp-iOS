//
//  TransactionCategoryCollectionViewCell.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 08.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

protocol TransactionCategoryCellViewModel {
    func categoryName() -> String?
    func categoryIcon() -> UIImage?
    func backgroundColor() -> UIColor?
}

class TransactionCategoryCellViewModelImpl: TransactionCategoryCellViewModel {
    
    private let category: TransactionCategoryManagedObject
    
    init(category: TransactionCategoryManagedObject) {
        self.category = category
    }
    
    func categoryName() -> String? {
        return category.name
    }
    
    func categoryIcon() -> UIImage? {
        guard let imageData = category.icon else { return nil }
        return UIImage(data: imageData as Data)
    }
    
    func backgroundColor() -> UIColor? {
        return UIColor(red: CGFloat(category.backgroundColorRedComponent),
                       green: CGFloat(category.backgroundColorGreenComponent),
                       blue: CGFloat(category.backgroundColorBlueComponent),
                       alpha: CGFloat(category.backgroundColorAlphaComponent))
    }
}

class TransactionCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var label: UILabel?
    @IBOutlet private weak var icon: UIImageView?
    
    func update(viewModel: TransactionCategoryCellViewModel) {
        label?.text = viewModel.categoryName()
        icon?.backgroundColor = viewModel.backgroundColor()
        icon?.image = viewModel.categoryIcon()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width * 0.5
    }
}


