//
//  MapperType.swift
//  MoneySaverFoundationiOS
//
//  Created by Michał Moskała on 21.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

public protocol MapperType {
    associatedtype FromType
    associatedtype ToType
    
    func map(fromType type: FromType) throws -> ToType
}
