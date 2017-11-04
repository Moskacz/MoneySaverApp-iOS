//
//  CurrentDateProvider.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

protocol CurrentDateProvider {
    func currentDate() -> Date
}

class CurrentDateProviderImpl: CurrentDateProvider {
    func currentDate() -> Date {
        return Date()
    }
}
