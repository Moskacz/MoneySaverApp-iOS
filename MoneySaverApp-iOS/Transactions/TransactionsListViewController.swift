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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        let cellNib = UINib(nibName: "TransactionTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: transactionCellIdentifier)
    }
    
    private func fetchData() {
        viewModel.fetchData().subscribe(onNext: { [weak self] (_) in
            self?.tableView.reloadData()
        }).addDisposableTo(disposeBag)
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
