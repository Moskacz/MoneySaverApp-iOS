//
//  TransactionsCloudKitClient.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 24.09.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CloudKit
import MoneySaverFoundationiOS

protocol TransactionsServerInterface {
    func saveTransaction(transaction: Transaction)
}

class TransactionsCloudKitServerInterface: TransactionsServerInterface {
    
    private let database = CKContainer.default().privateCloudDatabase
    
    func saveTransaction(transaction: Transaction) {
        let record = CKRecord(recordType: "Transaction")
        record["title"] = transaction.title as NSString
        record["value"] = transaction.value
        record["creationTimeInterval"] = NSNumber(value: transaction.creationTimeInterval)
        database.save(record) { (record: CKRecord?, error: Error?) in
            print(record as Any)
            print(error as Any)
        }
    }
}
