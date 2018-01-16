//
//  UserDefaultsProtocol.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 15.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

protocol KeyValueStorage {
    func value(forKey key: String) -> Any?
    func set(_ value: Any?, forKey key: String)
    func removeObject(forKey key: String)
}

extension UserDefaults: KeyValueStorage {}
