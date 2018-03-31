//
//  TransactionsListViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TransactionsListViewController: UIViewController {
    
    override lazy var tabBarItem: UITabBarItem! = {
        return UITabBarItem(title: "Transactions", image: #imageLiteral(resourceName: "transactions_notes"), selectedImage: #imageLiteral(resourceName: "transactions_notes"))
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var viewModel: TransactionsListViewModel? {
        didSet {
            if isViewLoaded {
                setup()
            }
        }
    }
    
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
        tableView?.rowHeight = 83
        tableView?.tableFooterView = UIView()
    }
    
    private func bindViewModel() {
        viewModel?.attach(updater: TableViewCollectionUpdater(tableView: tableView))
        if let summaryVC = childViewControllers.first as? TransactionsSummaryViewController {
            summaryVC.viewModel = viewModel?.summaryViewModel
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let summaryVC = segue.destination as? TransactionsSummaryViewController else { return }
        summaryVC.viewModel = viewModel?.summaryViewModel
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
}

extension TransactionsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = viewModel?.title(forSection: section)
        label.backgroundColor = UIColor.appBlack
        return label
    }
}
