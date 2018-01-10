//
//  String+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 10.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

extension String {
    
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    
}
