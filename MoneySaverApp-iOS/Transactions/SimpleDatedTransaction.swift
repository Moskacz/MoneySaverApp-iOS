//
//  SimpleDatedTransaction.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 18.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

struct SimpleDatedTransaction {
    let value: Decimal
    let dayOfEra: Int32
    let weekOfEra: Int32
    let year: Int32
}
