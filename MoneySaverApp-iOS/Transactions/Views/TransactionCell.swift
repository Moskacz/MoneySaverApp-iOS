//
//  TransactionCell.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 30.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var amoutLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func update(withViewModel viewModel: TransactionCellViewModel) {
        amoutLabel.text = viewModel.amountText()
        amoutLabel.textColor = viewModel.tintColor()
        descriptionLabel.text = viewModel.descriptionText()
        descriptionLabel.textColor = viewModel.tintColor()
    }
    
}
