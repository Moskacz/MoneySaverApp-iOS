//
//  FormError.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 09.10.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

enum CoreError: Error {
    case emptyData
    case invalidData
    
    func defaultMessage() -> String {
        switch self {
        case .emptyData:
            return "Empty data"
        case .invalidData:
            return "Invalid data"
        }
    }
}


