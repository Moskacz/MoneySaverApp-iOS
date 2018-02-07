//
//  TransactionCell.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 30.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet private weak var amoutLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var dateLabel: UILabel?
    @IBOutlet private weak var indicatorView: UIView?
    
    func update(withViewModel viewModel: TransactionCellViewModel) {
        amoutLabel?.text = viewModel.titleText()
        descriptionLabel?.text = viewModel.descriptionText()
        dateLabel?.text = viewModel.dateText()
        indicatorView?.backgroundColor = viewModel.indicatorColor()
    }
    
}
