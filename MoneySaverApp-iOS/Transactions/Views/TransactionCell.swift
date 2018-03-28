//
//  TransactionCell.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 30.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MMFoundation

class TransactionCell: UITableViewCell {
    
    @IBOutlet private weak var dividerViewHeightConstraint: NSLayoutConstraint?
    @IBOutlet private weak var containerView: UIView?
    @IBOutlet private weak var iconImageView: UIImageView?
    @IBOutlet private weak var amoutLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var dateLabel: UILabel?
    @IBOutlet private weak var indicatorView: GradientView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dividerViewHeightConstraint?.constant = 1.0/UIScreen.main.scale
    }
    
    func update(withViewModel viewModel: TransactionCellViewModel) {
        iconImageView?.image = viewModel.categoryIcon()
        amoutLabel?.text = viewModel.titleText()
        descriptionLabel?.text = viewModel.descriptionText()
        dateLabel?.text = viewModel.dateText()
        indicatorView?.gradient = viewModel.indicatorGradient()
    }
}
