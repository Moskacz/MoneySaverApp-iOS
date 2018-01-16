//
//  UserDefaultsProtocol.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 15.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

protocol UserDefaultsProtocol {
    func set(_ value: Int, forKey: String)
    func integer(forKey key: String) -> Int
}

extension UserDefaults: UserDefaultsProtocol {}
