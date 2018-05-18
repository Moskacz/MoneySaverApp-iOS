//
//  AddTransactionViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MMFoundation
import MoneySaverAppCore

enum TransactionValueSign: Int {
    case minus
    case plus
    
    init(transactionType: TransactionType) {
        switch transactionType {
        case .income: self = .plus
        case .expense: self = .minus
        }
    }
    
    func charRepresentation() -> Character? {
        switch self {
        case .plus:
            return nil
        case .minus:
            return Character("-")
        }
    }
}

class TransactionDataViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView?
    @IBOutlet private weak var titleTextField: UITextField?
    @IBOutlet private weak var valueTextField: UITextField?
    @IBOutlet private weak var currentDateLabel: UILabel?
    @IBOutlet private weak var currentDateChevron: UIImageView?
    @IBOutlet private weak var datePicker: UIDatePicker?
    
    private var keyboardObserver: KeyboardAppearObserver?
    private let availableTypes = [TransactionType.income, TransactionType.expense]
    
    var dataEnteredCallback: (TransactionData) -> Void = { _ in }
    var cancelButtonTapCallback: () -> Void = {}
    var viewModel: TransactionDataViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardObserver()
        setupViews()
        setupInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField?.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        currentResponder?.resignFirstResponder()
    }
    
    private func setupKeyboardObserver() {
        guard let scroll = scrollView else { return }
        keyboardObserver = KeyboardAppearObserver(scrollView: scroll)
    }
    
    private func setupViews() {
        title = "New transaction"
        setupNavigationItems()
        datePicker?.isHidden = true
        datePicker?.alpha = 0
        setupTextFields()
    }
    
    private func setupNavigationItems() {
        let nextButton = UIBarButtonItem(title: "Add",
                                         style: .done,
                                         target: self,
                                         action: #selector(nextButtonTapped))
        navigationItem.rightBarButtonItem = nextButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func setupTextFields() {
        titleTextField?.delegate = self
        let typePickerView = TransactionTypePickerView.makeView()
        typePickerView.delegate = self
        typePickerView.selectedType = availableTypes[0]
        valueTextField?.inputAccessoryView = typePickerView
    }
    
    private func setupInitialData() {
        guard let model = viewModel else { return }
        setupValueField(withSign: TransactionValueSign.minus)
        datePicker?.date = model.transactionDate
        setup(transactionDate: model.transactionDate)
    }
    
    private func setup(transactionDate date: Date) {
        currentDateLabel?.text = viewModel?.formatted(date: date)
        viewModel?.transactionDate = date
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
            titleTextField?.displayAsIncorrect()
        case .missingValue, .invalidValue:
            valueTextField?.displayAsIncorrect()
        }
    }
    
    // MARK: Transaction value sign
    
    private func setupValueField(withSign sign: TransactionValueSign) {
        removeCurrentValueSign()
        guard let signChar = sign.charRepresentation() else { return }
        var text = valueTextField?.text ?? ""
        text.insert(signChar, at: text.startIndex)
        valueTextField?.text = text
    }
    
    private func removeCurrentValueSign() {
        guard
            let firstChar = valueTextField?.text?.first,
            !Character.decimalChars().contains(firstChar) else { return }
        
        var text = valueTextField?.text ?? ""
        text = String(text.dropFirst())
        valueTextField?.text = text
    }
    
    private var currentResponder: UIResponder? {
        return [titleTextField, valueTextField].compactMap { $0 }.first { $0.isFirstResponder }
    }
    
    // MARK: Transaction date
    
    @IBAction func currentDateTapped(_ sender: UITapGestureRecognizer) {
        toggleDatePickerVisibility()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        setup(transactionDate: sender.date)
    }
    
    private func toggleDatePickerVisibility() {
        guard let picker = datePicker else { return }
        if picker.isHidden {
            UIView.animate(withDuration: 0.3, animations: {
                picker.isHidden = false
                picker.alpha = 1
                self.currentDateChevron?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
                self.scrollView?.scrollToBottom(animated: true)
            })
        } else {
            picker.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                picker.isHidden = true
                self.currentDateChevron?.transform = .identity
            })
        }
    }
}

extension TransactionDataViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            valueTextField?.becomeFirstResponder()
            return false
        }
        return true
    }
}

extension TransactionDataViewController: TransactionTypePickerViewDelegate {
    func transactionType(picker: TransactionTypePickerView, didSelect type: TransactionType) {
        setupValueField(withSign: TransactionValueSign(transactionType: type))
    }
}
