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
    
    enum KeyPaths: String {
        case value = "value"
        case title = "title"
        case date = "date"
        case dayOfEra = "date.dayOfEra"
        case weekOfEra = "date.weekOfEra"
        case monthOfEra = "date.monthOfEra"
        case year = "date.year"
        case timeInterval = "date.timeInterval"
    }
}
