//
//  TransactionsOverviewViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 02.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit

final class TransactionsOverviewViewController: UIViewController {
    
    var viewModel: TransactionsOverviewViewModel?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let summaryVC = segue.destination as? TransactionsSummaryViewController {
            summaryVC.viewModel = viewModel?.summaryViewModel
        } else if let listVC = segue.destination as? TransactionsListViewController {
            listVC.viewModel = viewModel?.listViewModel
        }
    }
}
