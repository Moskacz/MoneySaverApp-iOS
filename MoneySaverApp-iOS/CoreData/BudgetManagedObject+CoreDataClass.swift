//
//  BudgetManagedObject+CoreDataClass.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 25.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//
//

import Foundation
import CoreData

public class BudgetManagedObject: NSManagedObject {

    enum AttributesNames: String {
        case value
    }
    
    enum SortDescriptors {
        case value
        
        var descriptor: NSSortDescriptor {
            return NSSortDescriptor(key: AttributesNames.value.rawValue, ascending: true)
        }
    }
    
}
