//
//  DateFormatterUtil.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

enum DateFormatterType: Int {
    case monthOnly
    case yearOnly
}

class DateFormatters {
    
    private static let cache = NSCache<NSNumber, DateFormatter>()
    
    class func formatter(forType type: DateFormatterType) -> DateFormatter {
        if let cachedFormatter = cache.object(forKey: NSNumber(value: type.rawValue)) {
            return cachedFormatter
        }
        let formatter = createFormatter(withType: type)
        cache.setObject(formatter, forKey: NSNumber(value: type.rawValue))
        return formatter
    }
    
    class private func createFormatter(withType type: DateFormatterType) -> DateFormatter {
        let formatter = DateFormatter()
        switch type {
        case .monthOnly:
            formatter.dateFormat = "MMMM"
        case .yearOnly:
            formatter.dateFormat = "YYYY"
        }
        return formatter
    }
}
