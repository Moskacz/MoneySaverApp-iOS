//
//  FakeUserDefaults.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 15.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
@testable import MoneySaverApp_iOS

class FakeUserDefaults: UserDefaultsProtocol {
    
    var setIntPassed: Int? = nil
    var integerForKeyToReturn: Int!
    
    func set(_ value: Int, forKey: String) {
        setIntPassed = value
    }
    
    func integer(forKey key: String) -> Int {
        return integerForKeyToReturn
    }
    
}
