//
//  TransactionsListViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionsListViewController: UIViewController {
    
    @IBOutlet private weak var dateIntervalsPickerView: DateIntervalPickerView?
    @IBOutlet private weak var tableView: UITableView?
    
    var viewModel: TransactionsListViewModel?
    
    private let transactionCellIdentifier = "kTransactionCellIdentifier"
    var newTransactionButtonTapCallback: (() -> ()) = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel?.attach(updater: TableViewCollectionUpdater(tableView: tableView))
    }
    
    private func setupViews() {
        dateIntervalsPickerView?.viewModel = viewModel?.dateIntervalsPickerViewModel()
        let cellNib = UINib(nibName: "TransactionCell", bundle: nil)
        tableView?.register(cellNib, forCellReuseIdentifier: transactionCellIdentifier)
        tableView?.tableFooterView = UIView()
    }
    
    @IBAction func addNewTransactionButtonTapped(_ sender: UIBarButtonItem) {
        newTransactionButtonTapCallback()
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
        let cellViewModel = model.transactionCellViewModel(atPath: indexPath)
        cell.update(withViewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard let model = viewModel, editingStyle == .delete else { return }
        model.deleteTransaction(atPath: indexPath)
    }
}

// MARK: UITableViewDelegate
extension TransactionsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TransactionCell.defaultHeight
    }
    
}
