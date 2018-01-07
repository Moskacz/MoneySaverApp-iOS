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
    private weak var eraElement: TransactionSummaryElementView?
    
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
        let eraElement = TransactionSummaryElementView()
        
        let stackView = UIStackView(arrangedSubviews: [todayElement, weekElement, monthElement, yearElement, eraElement])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        addSubview(stackView)
        stackView.matchParent()
        
        self.todayElement = todayElement
        self.weekElement = weekElement
        self.monthElement = monthElement
        self.yearElement = yearElement
        self.eraElement = eraElement
        
        setupSelectionGestureRecognizer()
    }
    
    private func setupSelectionGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(recognizer:)))
        addGestureRecognizer(recognizer)
    }
    
    @objc private func viewTapped(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: self)
        for element in elements {
            if element.frame.contains(tapLocation) {
                selectedElement?.isSelected = false
                element.isSelected = true
                break
            }
        }
    }
    
    private var elements: [TransactionSummaryElementView] {
        return [todayElement, weekElement, monthElement, yearElement, eraElement].flatMap { $0 }
    }
    
    private var selectedElement: TransactionSummaryElementView? {
        return elements.first { $0.isSelected }
    }
}

extension TransactionsSummaryView: TransactionsSummaryViewModelDelegate {
    
    func updateElement(viewModel: TransactionsSummaryElementViewModel, dateComponent: TransactionDateComponent) {
        switch dateComponent {
        case .dayOfEra:
            todayElement?.update(withViewModel: viewModel)
        case .weekOfYear:
            weekElement?.update(withViewModel: viewModel)
        case .month:
            monthElement?.update(withViewModel: viewModel)
        case .year:
            yearElement?.update(withViewModel: viewModel)
        case .era:
            eraElement?.update(withViewModel: viewModel)
        default:
            break
        }
    }
}

