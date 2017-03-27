//
//  UITableView+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 27.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueTypedCell<T>(withIdentifier identifier: String) -> T {
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
