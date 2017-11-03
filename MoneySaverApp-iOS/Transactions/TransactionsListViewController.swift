//
//  TransactionsListViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionsListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView?
    var viewModel: TransactionsListViewModel?
    
    private let transactionCellIdentifier = "kTransactionCellIdentifier"
    var addTransactionTapCallback: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel?.attach(updater: TableViewCollectionUpdater(tableView: tableView))
        viewModel?.delegate = self
    }
    
    private func setupTableView() {
        let cellNib = UINib(nibName: "TransactionCell", bundle: nil)
        tableView?.register(cellNib, forCellReuseIdentifier: transactionCellIdentifier)
        tableView?.tableFooterView = UIView()
    }
    
}

// MARK: UITableViewDataSource
extension TransactionsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.transactionsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel else { fatalError() }
        let cell: TransactionCell = tableView.dequeueTypedCell(withIdentifier: transactionCellIdentifier)
        let cellViewModel = model.transactionCellViewModel(atIndex: indexPath.row)
        cell.update(withViewModel: cellViewModel)
        return cell
    }
}

// MARK: UITableViewDelegate
extension TransactionsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TransactionCell.defaultHeight
    }
}

// MARK: UICollectionViewDelegate

// MARK: TransactionsListViewModelDelegatee
extension TransactionsListViewController: TransactionsListViewModelDelegate {
    func sumOfTransactionsUpdated(value: Decimal) {
        
    }
}
