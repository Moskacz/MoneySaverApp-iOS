//
//  TransactionsSummaryView.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.12.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionsSummaryView: UIView {
    
    var viewModel: TransactionsSummaryViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    private weak var todayElement: TransactionSummaryElementView?
    private weak var weekElement: TransactionSummaryElementView?
    private weak var monthElement: TransactionSummaryElementView?
    private weak var yearElement: TransactionSummaryElementView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let todayElement = TransactionSummaryElementView()
        let weekElement = TransactionSummaryElementView()
        let monthElement = TransactionSummaryElementView()
        let yearElement = TransactionSummaryElementView()
        
        let stackView = UIStackView(arrangedSubviews: [todayElement, weekElement, monthElement, yearElement])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.matchParent()
        
        self.todayElement = todayElement
        self.weekElement = weekElement
        self.monthElement = monthElement
        self.yearElement = yearElement
    }
}

extension TransactionsSummaryView: TransactionsSummaryViewModelDelegate {
    
    func updateElement(viewModel: TransactionsSummaryElementViewModel, dateComponent: TransactionDateComponent) {
        switch dateComponent {
        case .day:
            todayElement?.update(withViewModel: viewModel)
        case .weekOfYear:
            weekElement?.update(withViewModel: viewModel)
        case .month:
            monthElement?.update(withViewModel: viewModel)
        case .year:
            yearElement?.update(withViewModel: viewModel)
        default:
            break
        }
    }
}

