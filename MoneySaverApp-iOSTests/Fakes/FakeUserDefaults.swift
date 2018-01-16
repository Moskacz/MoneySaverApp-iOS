//
//  FakeUserDefaults.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 15.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
@testable import MoneySaverApp_iOS

class FakeUserDefaults: KeyValueStorage {
    
    var valuePassed: Any? = nil
    var valueForKeyToReturn: Any? = nil
    
    func value(forKey key: String) -> Any? {
        return valueForKeyToReturn
    }
    
    func set(_ value: Any?, forKey key: String) {
        valuePassed = value
    }
    
    func removeObject(forKey key: String) {
        
    }

}
