//
//  TransactionCategoryCollectionViewCell.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 08.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore

class TransactionCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var imageBackgroundView: UIView?
    @IBOutlet private weak var imageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBackgroundView?.backgroundColor = AppColor.main.value
    }
    
    func update(withViewModel viewModel: TransactionCategoryViewModel) {
        titleLabel?.text = viewModel.transactionName
        imageView?.image = viewModel.transactionIcon
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageBackgroundView?.makeLayerRound()
    }
}


