//
//  TransactionsSummaryView.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.12.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

protocol TransactionsSummaryViewDelegate: class {
    func summary(view: TransactionsSummaryView, didSelectElementWith component: TransactionDateComponent)
}

class TransactionsSummaryView: UIView {
    
    var viewModel: TransactionsSummaryViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    weak var delegate: TransactionsSummaryViewDelegate?
    private var elementsMapping = [(component: TransactionDateComponent, view: TransactionSummaryElementView)]()

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
        
        elementsMapping = [(TransactionDateComponent.dayOfEra, todayElement),
                           (TransactionDateComponent.weekOfYear, weekElement),
                           (TransactionDateComponent.month, monthElement),
                           (TransactionDateComponent.year, yearElement),
                           (TransactionDateComponent.era, eraElement)]
        
        setupSelectionGestureRecognizer()
    }
    
    // MARK: Elements mapping
    
    private func element(forComponent component: TransactionDateComponent) -> TransactionSummaryElementView? {
        return elementsMapping.first { $0.component == component }?.view
    }
    
    private func dateComponent(forElement element: TransactionSummaryElementView) -> TransactionDateComponent {
        return elementsMapping.first { $0.view == element }!.component
    }
    
    // MARK: Element selection
    
    func selectElement(dateComponent: TransactionDateComponent) {
        element(forComponent: dateComponent)?.isSelected = true
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
                delegate?.summary(view: self, didSelectElementWith: dateComponent(forElement: element))
                break
            }
        }
    }
    
    private var elements: [TransactionSummaryElementView] {
        return elementsMapping.map { $0.1 }
    }
}

extension TransactionsSummaryView: TransactionsSummaryViewModelDelegate {
    
    func updateElement(viewModel: TransactionsSummaryElementViewModel, dateComponent: TransactionDateComponent) {
        element(forComponent: dateComponent)?.update(withViewModel: viewModel)
    }
}

