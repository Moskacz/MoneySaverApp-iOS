//
//  TransactionCategoryView.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 14.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

protocol TransactionCategoryViewModel {
    func transactionName() -> String?
    func transactionIcon() -> UIImage?
}

class TransactionCategoryView: UIView {
    
    private weak var categoryNameLabel: UILabel?
    private weak var categoryIconImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: Setup
    
    private func setupView() {
        addLabel()
        addImageView()
    }
    
    private func addLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        addSubview(label)
        label.matchParentHorizontally()
        label.pinToParentBottom()
        self.categoryNameLabel = label
    }
    
    private func addImageView() {
        guard let label = categoryNameLabel else { return }
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.pinToParentTop()
        imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: 8).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.categoryIconImageView = imageView
    }
    
    // MARK: Upadting
    
    public func update(withViewModel viewModel: TransactionCategoryViewModel) {
        categoryNameLabel?.text = viewModel.transactionName()
        categoryIconImageView?.image = viewModel.transactionIcon()
    }
}
