
//
//  File.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 25.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore

class SetupBudgetViewController: UIViewController {
    
    var presenter: SetupBudgetPresenterProtocol!
    
    @IBOutlet private weak var budgetTextField: UITextField?
    @IBOutlet private weak var confirmButton: UIButton?
    @IBOutlet private weak var closeButton: UIButton?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        closeButton?.isHidden = !isPresented
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        confirmButton?.backgroundColor = AppColor.activeElement.value
        closeButton?.backgroundColor = AppColor.activeElement.value
    }
    
    // MARK: UI Actions
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        presenter.save(budget: budgetTextField?.text)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        presenter.closeViewClicked()
    }
}

extension SetupBudgetViewController: SetupBudgetUI {
    
    func display(error: SetupBudgetError) {
        budgetTextField?.displayAsIncorrect()
    }
}
