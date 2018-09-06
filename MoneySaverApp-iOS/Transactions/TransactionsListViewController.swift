//
//  TransactionsListViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore

class TransactionsListViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var coordinator: TransactionsListCoordinator!
    weak var externalScrollViewDelegate: UIScrollViewDelegate?
    
    @IBOutlet weak var tableView: UITableView?
    private let transactionCellIdentifier = "kTransactionCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupViews()
    }
    
    private func setupViews() {
        tableView?.register(cell: TransactionTableViewCell.self)
        tableView?.separatorColor = UIColor.clear
        tableView?.rowHeight = 92
        tableView?.tableFooterView = UIView()
    }
}

extension TransactionsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return coordinator.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinator.numberOfRowsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransactionTableViewCell = tableView.dequeue()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        coordinator.markTransactionForDeletion(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return coordinator?.titleFor(section: section)
    }
}

extension TransactionsListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        externalScrollViewDelegate?.scrollViewDidScroll?(scrollView)
    }
}
