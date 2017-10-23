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
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.matchParent()
        self.stackView = stackView
    }
    
    private func addLabel(text: String?) {
        guard text != nil else {
            removeFromStackView(view: categoryNameLabel)
            return
        }
        
        guard categoryNameLabel == nil else {
            categoryNameLabel?.text = text
            return
        }
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = text
        addSubview(label)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        self.categoryNameLabel = label
        stackView?.addArrangedSubview(label)
    }
    
    private func addImageView(image: UIImage?, backgroundColor: UIColor?) {
        guard categoryIconImageView == nil else {
            categoryIconImageView?.image = image
            return
        }
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor.white
        imageView.image = image
        imageView.backgroundColor = backgroundColor
        imageView.layer.cornerRadius = 8
        self.categoryIconImageView = imageView
        stackView?.addArrangedSubview(imageView)
    }
    
    private func removeFromStackView(view: UIView?) {
        guard let viewToRemove = view else { return }
        stackView?.removeArrangedSubview(viewToRemove)
        viewToRemove.removeFromSuperview()
    }
    
    // MARK: Upadting
    
    public func update(withViewModel viewModel: TransactionCategoryViewModel) {
        addImageView(image: viewModel.transactionIcon()?.withRenderingMode(.alwaysTemplate),
                     backgroundColor: viewModel.backgroundColor())
        addLabel(text: viewModel.transactionName())
    }
}


