//
//  TransactionCell.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 30.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore
import MMFoundation

class TransactionTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet private weak var dividerViewHeightConstraint: NSLayoutConstraint?
    @IBOutlet private weak var iconImageViewContainer: GradientView?
    @IBOutlet private weak var iconImageView: UIImageView?
    @IBOutlet private weak var amoutLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var dateLabel: UILabel?
    @IBOutlet private weak var indicatorView: GradientView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dividerViewHeightConstraint?.constant = 1.0/UIScreen.main.scale
        iconImageViewContainer?.update(with: AppGradient.main.value)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let view = iconImageViewContainer {
            view.layer.cornerRadius = view.bounds.width * 0.5
        }
    }
}

extension TransactionTableViewCell: TransactionCell {
    
    func set(icon: Image?) {
        iconImageView?.image = icon
    }
    
    func set(amount: String?) {
        amoutLabel?.text = amount
    }
    
    func set(title: String?) {
        descriptionLabel?.text = title
    }
    
    func set(date: String?) {
        dateLabel?.text = date
    }
    
    func set(indicator: Gradient?) {
        indicatorView?.update(with: indicator)
    }
}
