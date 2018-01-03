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
    
    enum AttributesNames: String {
        case value
        case creationTimeInterval
        case dayOfYear
    }
    
    enum SortDescriptors {
        case dayOfYear
        case creationTimeInterval
        
        var value: NSSortDescriptor {
            switch self {
            case .dayOfYear:
                return NSSortDescriptor(key: AttributesNames.dayOfYear.rawValue,
                                        ascending: false)
            case .creationTimeInterval:
                return NSSortDescriptor(key: AttributesNames.creationTimeInterval.rawValue,
                                        ascending: false)
            }
        }
    }
}
