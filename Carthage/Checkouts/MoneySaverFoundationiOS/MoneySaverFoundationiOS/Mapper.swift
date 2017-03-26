//
//  Mapper.swift
//  MoneySaverFoundationiOS
//
//  Created by Michał Moskała on 21.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

public enum MappingError: Error {
    case couldNotParse
}

open class Mapper<T,U>: MapperType {
    public typealias FromType = T
    public typealias ToType = U
    
    public init() {}
    
    open func map(fromType type: T) throws -> U {
        throw MappingError.couldNotParse
    }
}
