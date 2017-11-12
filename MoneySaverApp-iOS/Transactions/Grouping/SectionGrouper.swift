//
//  SectionGrouper.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 11.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

class SectionGrouper<T> {
    func group(items: [T]) -> [SectionModel<T>] {
        return []
    }
}

class TransactionsSectionGrouper: SectionGrouper<TransactionManagedObject> {
    
    override func group(items: [TransactionManagedObject]) -> [SectionModel<TransactionManagedObject>] {
        return []
    }
}
