//
//  AddTransactionViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController {
    
    static let storyboardId = "AddTransactionViewController"
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    
    var transactionAddedCallback: ((Void) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func doneButtonTapped() {
        transactionAddedCallback?()
    }
}
