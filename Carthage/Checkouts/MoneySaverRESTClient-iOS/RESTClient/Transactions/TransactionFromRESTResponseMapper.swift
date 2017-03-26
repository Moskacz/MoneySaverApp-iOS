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
        guard let title = type["title"] as? String,
            let value = type["value"] as? Double,
            let category = type["category"] as? String else {
                throw MappingError.couldNotParse
        }
        
        return Transaction(title: title,
                           value: NSDecimalNumber(value: value),
                           category: category)
    }
}
