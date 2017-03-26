//
//  Transaction.swift
//  MoneySaverFoundationiOS
//
//  Created by Michał Moskała on 21.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

public struct Transaction {
    public let title: String
    public let value: NSDecimalNumber
    public let category: String
    
    public init(title: String, value: NSDecimalNumber, category: String) {
        self.title = title
        self.value = value
        self.category = category
    }
}
