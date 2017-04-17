//
//  TransactionFromRESTResponseMapper.swift
//  RESTClient
//
//  Created by Michał Moskała on 22.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverFoundationiOS

class TransactionFromRESTResponseMapper: Mapper<[AnyHashable:Any], Transaction> {
    
    override func map(fromType type: [AnyHashable : Any]) throws -> Transaction {
        guard
            let identifier = type["_id"] as? String,
            let title = type["title"] as? String,
            let value = type["value"] as? Double,
            let category = type["category"] as? String,
            let creationTimeInterval = type["creationTimeInterval"] as? TimeInterval else {
                throw MappingError.couldNotParse
        }
        
        return Transaction(identifier: identifier,
                           title: title,
                           value: NSDecimalNumber(value: value),
                           category: category,
                           creationTimeInterval: creationTimeInterval)
    }
}
