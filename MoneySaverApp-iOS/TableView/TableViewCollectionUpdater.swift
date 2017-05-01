//
//  TableViewCollectionUpdater.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 14.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class TableViewCollectionUpdater: CollectionUpdater {
    
    private weak var tableView: UITableView?
    
    init(tableView: UITableView?) {
        self.tableView = tableView
    }
    
    // MARK: CollectionUpdater
    
    func beginUpdates() {
        tableView?.beginUpdates()
    }
    
    func insertRow(at indexPaths: [IndexPath]) {
        tableView?.insertRows(at: indexPaths, with: .automatic)
    }
    
    func deleteRow(at indexPaths: [IndexPath]) {
        tableView?.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        tableView?.moveRow(at: fromIndexPath, to: toIndexPath)
    }
    
    func reload(at indexPaths: [IndexPath]) {
        tableView?.reloadRows(at: indexPaths, with: .automatic)
    }
    
    func endUpdates() {
        tableView?.endUpdates()
    }
    
    func reloadAll() {
        tableView?.reloadData()
    }
}
