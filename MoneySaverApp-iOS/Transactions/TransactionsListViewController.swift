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
    
    var viewModel: TransactionsListViewModel?
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
        let cellNib = UINib(nibName: "TransactionCell", bundle: nil)
        tableView?.separatorColor = UIColor.clear
        tableView?.register(cellNib, forCellReuseIdentifier: transactionCellIdentifier)
        tableView?.rowHeight = 92
        tableView?.tableFooterView = UIView()
    }
}

extension TransactionsListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        externalScrollViewDelegate?.scrollViewDidScroll?(scrollView)
    }
}
