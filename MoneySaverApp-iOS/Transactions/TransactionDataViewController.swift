//
//  AddTransactionViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import RxSwift

struct TransactionData {
    let title: String
    let value: Decimal
}

class TransactionDataViewController: UIViewController {
    
    @IBOutlet private weak var titleTextField: UITextField?
    @IBOutlet private weak var valueTextField: UITextField?
    
    var dataEnteredCallback: (TransactionData) -> Void = { _ in }
    var cancelButtonTapCallback: () -> Void = {}
    var viewModel: TransactionDataViewModel?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let nextButton = UIBarButtonItem(title: "Next",
                                         style: .done,
                                         target: self,
                                         action: #selector(nextButtonTapped))
        navigationItem.rightBarButtonItem = nextButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc func nextButtonTapped() {
        guard let model = viewModel else { return }
        passDataToViewModel()
        do {
            let data = try model.data()
            dataEnteredCallback(data)
        } catch {
            handle(error: error)
        }
    }
    
    @objc func cancelButtonTapped() {
        cancelButtonTapCallback()
    }
    
    private func passDataToViewModel() {
        viewModel?.transactionTitle = titleTextField?.text
        viewModel?.transactionValue = valueTextField?.text
    }
    
    private func handle(error: Error) {
        guard let formError = error as? TransactionDataFormError else { return }
        handle(error: formError)
    }
    
    private func handle(error: TransactionDataFormError) {
        switch error {
        case .missingTitle:
            showIncorrect(field: titleTextField)
        case .missingValue, .invalidValue:
            showIncorrect(field: valueTextField)
        }
    }
    
    private func showIncorrect(field: UITextField?) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.autoreverse], animations: {
            field?.backgroundColor = Theme.errorColor
        }, completion: { (_) in
            field?.backgroundColor = UIColor.white
        })
    }
}
