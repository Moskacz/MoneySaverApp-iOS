//
//  SettingsViewController.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 02.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = "Settings"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}
