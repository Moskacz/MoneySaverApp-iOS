//
//  TransactionCategoryView.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 14.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionCategoryView: UIView {
    
    private weak var categoryNameLabel: UILabel?
    private weak var categoryIconContainerView: UIView?
    private weak var categoryIconImageView: UIImageView?
    private weak var stackView: UIStackView?
    
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
        setupStackView()
        setupIconImageView()
        setupLabel()
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.matchParent()
        self.stackView = stackView
    }
    
    private func setupLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        self.categoryNameLabel = label
        stackView?.addArrangedSubview(label)
    }
    
    private func setupIconImageView() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 8
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
    
        containerView.addSubview(imageView)
        imageView.matchParent(edgeInsets: UIEdgeInsetsMake(8, 8, -8, -8))
        self.categoryIconImageView = imageView
        self.categoryIconContainerView = containerView
        stackView?.addArrangedSubview(containerView)
    }
    
    // MARK: Upadting
    
    public func update(withViewModel viewModel: TransactionCategoryViewModel) {
        categoryIconImageView?.image = viewModel.transactionIcon()
        categoryIconContainerView?.backgroundColor = viewModel.backgroundColor()
        let transactionName = viewModel.transactionName()
        categoryNameLabel?.text = transactionName
        stackView?.spacing = transactionName == nil ? 0 : 8
    }
}


