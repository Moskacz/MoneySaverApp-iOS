//
//  DumbCollectionUpdater.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 14.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

class ReloadTableViewCollectionUpdater: CollectionUpdater {
    
    private weak var tableView: UITableView?
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func endUpdates() {
        tableView?.reloadData()
    }
    
    func beginUpdates() {}
    func insertRow(at indexPaths: [IndexPath]) {}
    func deleteRow(at indexPaths: [IndexPath]) {}
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath) {}
    func reload(at indexPaths: [IndexPath]) {}
}
