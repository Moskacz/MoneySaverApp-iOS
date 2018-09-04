//
//  TransactionsListTableViewAdapter.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.09.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import UIKit
import MoneySaverAppCore
import MMFoundation

internal final class TransactionsListTableViewAdapter: ResultsControllerTableViewAdapter<TransactionProtocol, TransactionTableViewCell, TransactionCellDescriptor<TransactionTableViewCell>> {
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "test"
    }
}
