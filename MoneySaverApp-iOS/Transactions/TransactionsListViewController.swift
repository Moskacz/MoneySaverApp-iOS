//
//  TransactionsListViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionsListViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var viewModel: TransactionsListViewModel?
    
    @IBOutlet private weak var tableView: UITableView?
    private let transactionCellIdentifier = "kTransactionCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupViews()
        bindViewModel()
    }
    
    private func setupViews() {
        let cellNib = UINib(nibName: "TransactionCell", bundle: nil)
        tableView?.separatorColor = UIColor.clear
        tableView?.register(cellNib, forCellReuseIdentifier: transactionCellIdentifier)
        tableView?.rowHeight = 87
        tableView?.tableFooterView = UIView()
    }
    
    private func bindViewModel() {
        viewModel?.attach(updater: TableViewCollectionUpdater(tableView: tableView))
    }
}

extension TransactionsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sectionsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.transactionsCount(inSection:  section) ?? 0
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.title(forSection: section)
    }
    
}
