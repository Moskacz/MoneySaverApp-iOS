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
    func backgroundColor() -> UIColor?
}

class TransactionCategoryView: UIView {
    
    private weak var categoryNameLabel: UILabel?
    private weak var categoryIconContainerView: UIView?
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
        addContainerView()
        addImageView()
    }
    
    private func addLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        addSubview(label)
        label.matchParentHorizontally()
        label.pinToParentBottom()
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        self.categoryNameLabel = label
    }
    
    private func addContainerView() {
        guard let label = categoryNameLabel else { return }
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        addSubview(view)
        view.matchParentHorizontally()
        view.pinToParentTop()
        view.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -8).isActive = true
        self.categoryIconContainerView = view
    }
    
    private func addImageView() {
        guard let containverView = categoryIconContainerView else { return }
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containverView.addSubview(imageView)
        imageView.matchParentVertically(edges: UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0))
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: containverView.centerXAnchor).isActive = true
        self.categoryIconImageView = imageView
    }
    
    // MARK: Upadting
    
    public func update(withViewModel viewModel: TransactionCategoryViewModel) {
        categoryNameLabel?.text = viewModel.transactionName()
        categoryIconImageView?.image = viewModel.transactionIcon()
        categoryIconContainerView?.backgroundColor = viewModel.backgroundColor()
    }
}
