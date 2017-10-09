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
    let value: NSDecimalNumber
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
        dataEnteredCallback(TransactionData(title: "", value: NSDecimalNumber(string: "10")))
    }
    
    @objc func cancelButtonTapped() {
        cancelButtonTapCallback()
    }
}
