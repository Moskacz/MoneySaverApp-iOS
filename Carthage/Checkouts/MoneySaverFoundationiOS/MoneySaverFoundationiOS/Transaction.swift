//
//  Transaction.swift
//  MoneySaverFoundationiOS
//
//  Created by Michał Moskała on 21.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

public struct Transaction {
    public let identifier: UUID
    public let title: String
    public let value: NSDecimalNumber
    public let creationTimeInterval: TimeInterval
    public let category: TransactionCategory
    
    public init(identifier: UUID,
                title: String,
                value: NSDecimalNumber,
                creationTimeInterval: TimeInterval,
                category: TransactionCategory) {
        self.identifier = identifier
        self.title = title
        self.value = value
        self.creationTimeInterval = creationTimeInterval
        self.category = category
    }
}
