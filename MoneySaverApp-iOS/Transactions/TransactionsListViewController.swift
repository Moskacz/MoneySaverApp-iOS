//
//  TransactionsListViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import RxSwift

class TransactionsListViewController: UIViewController, UITableViewDataSource {
    
    static let storyboardId = "TransactionsListViewController"
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: TransactionsListViewModel!
    
    private let transactionCellIdentifier = "kTransactionCellIdentifier"
    private let disposeBag = DisposeBag()
    var addTransactionTapCallback: ((Void) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.attach(updater: ReloadTableViewCollectionUpdater(tableView: tableView))
        viewModel.refreshData()
    }
    
    // MARK: Initial setup
    
    private func setupViews() {
        setupTableView()
        setupNavigationItems()
    }
    
    private func setupTableView() {
        let cellNib = UINib(nibName: "TransactionTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: transactionCellIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    private func setupNavigationItems() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTransactionButtonTapped))
        navigationItem.rightBarButtonItem = addItem
    }
    
    func addTransactionButtonTapped() {
        addTransactionTapCallback?()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactionsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransactionTableViewCell = tableView.dequeueTypedCell(withIdentifier: transactionCellIdentifier)
        let transaction = viewModel.transaction(atIndex: indexPath.row)
        cell.titleLabel.text = transaction.title
        return cell
    }
}
