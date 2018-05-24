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
    
    var configureSummaryVC: (TransactionsSummaryViewController) -> Void = { _ in }
    var configureTransactionsListViewController: (TransactionsListViewController) -> Void = { _ in }
    
    private let SUMMARY_VIEW_HEIGHT = CGFloat(200)
    @IBOutlet private weak var summaryViewHeightConstraint: NSLayoutConstraint?
    @IBOutlet private weak var listTopConstraint: NSLayoutConstraint?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Transactions", image: #imageLiteral(resourceName: "transactions_notes"), selectedImage: #imageLiteral(resourceName: "transactions_notes"))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        summaryViewHeightConstraint?.constant = SUMMARY_VIEW_HEIGHT
        listTopConstraint?.constant = SUMMARY_VIEW_HEIGHT
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let summaryVC = segue.destination as? TransactionsSummaryViewController {
            summaryVC.viewModel = viewModel?.summaryViewModel
            configureSummaryVC(summaryVC)
        } else if let listVC = segue.destination as? TransactionsListViewController {
            listVC.viewModel = viewModel?.listViewModel
        }
    }
}
