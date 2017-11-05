//
//  DateIntervalCell.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 03.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

protocol DateIntervalCellViewModel {
    func intervalTitle() -> String?
    func intervalDescription() -> String?
    func transactionsSum() -> String?
}

class DateIntervalCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var sumLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 16
    }
    
    func update(withViewModel viewModel: DateIntervalCellViewModel) {
        titleLabel?.text = viewModel.intervalTitle()
        descriptionLabel?.text = viewModel.intervalDescription()
        sumLabel?.text = viewModel.transactionsSum()
    }
}
