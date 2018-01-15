//
//  TransactionsSummaryView.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.12.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

protocol TransactionsSummaryViewDelegate: class {
    func summary(view: TransactionsSummaryView, didSelectElementWith dateRange: DateRange)
}

class TransactionsSummaryView: UIView {
    
    var viewModel: TransactionsSummaryViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    weak var delegate: TransactionsSummaryViewDelegate?
    private var elementsMapping = [(dateRange: DateRange, view: TransactionSummaryElementView)]()

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
        let thisWeekElement = TransactionSummaryElementView()
        let thisMonthElement = TransactionSummaryElementView()
        let thisYearElement = TransactionSummaryElementView()
        let allTimeElement = TransactionSummaryElementView()
        
        let stackView = UIStackView(arrangedSubviews: [todayElement,
                                                       thisWeekElement,
                                                       thisMonthElement,
                                                       thisYearElement,
                                                       allTimeElement])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        addSubview(stackView)
        stackView.matchParent()
        
        elementsMapping = [(.today, todayElement),
                           (.thisWeek, thisWeekElement),
                           (.thisMonth, thisMonthElement),
                           (.thisYear, thisYearElement),
                           (.allTime, allTimeElement)]
        
        setupSelectionGestureRecognizer()
    }
    
    // MARK: Elements mapping
    
    private func element(forRange range: DateRange) -> TransactionSummaryElementView? {
        return elementsMapping.first { $0.dateRange == range }?.view
    }
    
    private func dateRange(forElement element: TransactionSummaryElementView) -> DateRange {
        return elementsMapping.first { $0.view == element }!.dateRange
    }
    
    // MARK: Element selection
    
    func selectElement(withRange range: DateRange) {
        element(forRange: range)?.isSelected = true
    }
    
    private func deselectCurrentlySelected() {
        elements.first { $0.isSelected }?.isSelected = false
    }
    
    private func setupSelectionGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(recognizer:)))
        addGestureRecognizer(recognizer)
    }
    
    @objc private func viewTapped(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: self)
        for element in elements {
            if element.frame.contains(tapLocation) {
                deselectCurrentlySelected()
                element.isSelected = true
                delegate?.summary(view: self, didSelectElementWith: dateRange(forElement: element))
                break
            }
        }
    }
    
    private var elements: [TransactionSummaryElementView] {
        return elementsMapping.map { $0.1 }
    }
}

extension TransactionsSummaryView: TransactionsSummaryViewModelDelegate {
    
    func updateElement(viewModel: TransactionsSummaryElementViewModel, dateRange: DateRange) {
        element(forRange: dateRange)?.update(withViewModel: viewModel)
    }
    
}
