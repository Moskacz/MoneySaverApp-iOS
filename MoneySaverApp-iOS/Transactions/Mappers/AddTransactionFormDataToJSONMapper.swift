//
//  AddTransactionFormDataToJSONMapper.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 08.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverFoundationiOS

class AddTransactionFormDataToJSONMapper: Mapper<AddTransactionFormData, [AnyHashable: Any]> {
    
    override func map(fromType type: AddTransactionFormData) throws -> [AnyHashable : Any] {
        var parameters: [AnyHashable: Any] = [:]
        parameters["title"] = type.title
        parameters["category"] = type.category
        parameters["value"] = type.value
        parameters["creationTimeInterval"] = type.creationTimeStamp
        return parameters
    }
}
