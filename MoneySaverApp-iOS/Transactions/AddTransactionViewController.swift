//
//  AddTransactionViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import RxSwift

class AddTransactionViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    
    private let disposeBag = DisposeBag()
    var transactionAddedCallback: (() -> Void) = {}
    var cancelButtonTapCallback: (() -> Void) = {}
    var viewModel: AddTransactionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc func doneButtonTapped() {
        setDataOnViewModel()
        viewModel.addTransaction().subscribe(onNext: { [weak self] in
            self?.transactionAddedCallback()
        }, onError: { (error: Error) in
            print(error)
        }).addDisposableTo(disposeBag)
    }
    
    @objc func cancelButtonTapped() {
        cancelButtonTapCallback()
    }
    
    private func setDataOnViewModel() {
        viewModel.title = titleTextField.text
        viewModel.value = valueTextField.text
    }
}
