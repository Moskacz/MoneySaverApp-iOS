//
//  DateIntervalCell.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 03.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class DateIntervalCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
}
