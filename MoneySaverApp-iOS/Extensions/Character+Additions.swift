//
//  Character+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 07.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

extension Character {
    
    static func decimalChars() -> [Character] {
        return (0..<10).map { Character("\($0)") }
    }
}
