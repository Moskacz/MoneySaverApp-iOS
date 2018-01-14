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
        case dayOfWeek
        case dayOfMonth
        case dayOfYear
        case dayOfEra
        case weekOfMonth
        case weekOfYear
        case weekOfEra
        case monthOfYear
        case monthOfEra
        case year
    }
    
    enum SortDescriptors {
        case dayOfEra
        case creationTimeInterval
        
        var descriptor: NSSortDescriptor {
            switch self {
            case .dayOfEra:
                return NSSortDescriptor(key: AttributesNames.dayOfEra.rawValue,
                                        ascending: false)
            case .creationTimeInterval:
                return NSSortDescriptor(key: AttributesNames.creationTimeInterval.rawValue,
                                        ascending: false)
            }
        }
    }
    
    static func predicate(forDateRange range: DateRange, value: Int) -> NSPredicate? {
        guard range != .allTime else { return nil }
        return nil
    }
    
    func setupDateComponents(date: StructuredDate) {
        creationTimeInterval = date.timeInterval
        dayOfWeek = Int32(date.dayOfWeek)
        dayOfMonth = Int32(date.dayOfMonth)
        dayOfYear = Int32(date.dayOfYear)
        dayOfEra = Int32(date.dayOfEra)
        weekOfMonth = Int32(date.weekOfMonth)
        weekOfYear = Int32(date.weekOfYear)
        weekOfEra = Int32(date.weekOfEra)
        monthOfYear = Int32(date.monthOfYear)
        monthOfEra = Int32(date.monthOfEra)
        year = Int32(date.year)
    }
}
