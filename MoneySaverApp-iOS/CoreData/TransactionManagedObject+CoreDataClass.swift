//
//  TransactionManagedObject+CoreDataClass.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 29.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

public class TransactionManagedObject: NSManagedObject {
    
    enum KeyPath: String {
        case value = "value"
        case title = "title"
        case date = "date"
        case dayOfEra = "date.dayOfEra"
        case weekOfEra = "date.weekOfEra"
        case monthOfEra = "date.monthOfEra"
        case year = "date.year"
        case timeInterval = "date.timeInterval"
    }
    
    static func groupByKeypathFor(grouping: TransactionsGrouping) -> KeyPath {
        switch grouping {
        case .day: return KeyPath.dayOfEra
        case .week: return KeyPath.weekOfEra
        case .month: return KeyPath.monthOfEra
        }
    }
}

extension TransactionManagedObject: TransactionProtocol {
    var transactionCategory: TransactionCategoryProtocol? {
        return category
    }
    var transactionDate: CalendarDateProtocol? {
        return date
    }
}
