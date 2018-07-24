//
//  TransactionsOverviewViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 02.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import MoneySaverAppCore

final class TransactionsOverviewViewController: UIViewController {
    
    var configureSummaryVC: (TransactionsSummaryViewController) -> Void = { _ in }
    var configureTransactionsListViewController: (TransactionsListViewController) -> Void = { _ in }
    
    private let SUMMARY_VIEW_HEIGHT = CGFloat(200)
    
    @IBOutlet private weak var summaryViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var summaryViewContainer: UIView!
    @IBOutlet private weak var listTopConstraint: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Transactions", image: #imageLiteral(resourceName: "transactions_notes"), selectedImage: #imageLiteral(resourceName: "transactions_notes"))
    }
    
    override func loadView() {
        super.loadView()
        summaryViewHeightConstraint.constant = SUMMARY_VIEW_HEIGHT
        listTopConstraint.constant = SUMMARY_VIEW_HEIGHT
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let summaryVC = segue.destination as? TransactionsSummaryViewController {
            configureSummaryVC(summaryVC)
        } else if let listVC = segue.destination as? TransactionsListViewController {
            listVC.externalScrollViewDelegate = self
            configureTransactionsListViewController(listVC)
        }
    }
}

extension TransactionsOverviewViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = -scrollView.contentOffset.y
        let summaryViewHeight = max(SUMMARY_VIEW_HEIGHT + offset, SUMMARY_VIEW_HEIGHT)
        if fabs(summaryViewHeightConstraint.constant - summaryViewHeight) > 1 {
            summaryViewHeightConstraint.constant = max(SUMMARY_VIEW_HEIGHT + offset, SUMMARY_VIEW_HEIGHT)
            view.setNeedsLayout()
        }
    }
}
