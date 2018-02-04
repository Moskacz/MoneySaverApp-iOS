//
//  TransactionCategoryProtocol.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit

protocol TransactionCategoryProtocol {
    var name: String? { get }
    var image: UIImage? { get }
    var categoryColor: UIColor? { get }
}
