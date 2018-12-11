//
//  TransactionsListViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import MMFoundation
import MoneySaverAppCore

class TransactionsListViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var presenter: TransactionsListPresenterProtocol!
    weak var externalScrollViewDelegate: UIScrollViewDelegate?
    
    @IBOutlet weak var tableView: UITableView?
    private let transactionCellIdentifier = "kTransactionCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.start()
        tableView?.reloadData()
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
        return presenter.sectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.itemsCount(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransactionTableViewCell = tableView.dequeue()
        let item = presenter.item(at: indexPath)
        
        cell.set(title: item.titleText)
        cell.set(amount: item.descriptionText)
        cell.set(icon: item.categoryIcon)
        cell.set(date: item.dateText)
        cell.set(indicator: item.indicatorGradient)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        presenter.deleteItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return presenter.title(for: section)
    }
}

extension TransactionsListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        externalScrollViewDelegate?.scrollViewDidScroll?(scrollView)
    }
}

extension TransactionsListViewController: TransactionsListUI {
    
    func displayNoData() {
        #warning("implement")
    }
}

extension TransactionsListViewController: ResultsControllerDelegate {
    
    func resultsControllerWillChangeContent() {
        tableView?.resultsControllerWillChangeContent()
    }
    
    func resultsControllerDid(change: ResultChangeType) {
        tableView?.resultsControllerDid(change: change)
    }
    
    func resultsControllerDidChangeContent() {
        tableView?.resultsControllerDidChangeContent()
    }
}
