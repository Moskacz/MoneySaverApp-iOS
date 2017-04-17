//
//  Transaction.swift
//  MoneySaverFoundationiOS
//
//  Created by Michał Moskała on 21.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

public struct Transaction {
    public let identifier: String
    public let title: String
    public let value: NSDecimalNumber
    public let category: String
    public let creationTimeInterval: TimeInterval
    
    public init(identifier: String,
                title: String,
                value: NSDecimalNumber,
                category: String,
                creationTimeInterval: TimeInterval) {
        self.identifier = identifier
        self.title = title
        self.value = value
        self.category = category
        self.creationTimeInterval = creationTimeInterval
    }
}
