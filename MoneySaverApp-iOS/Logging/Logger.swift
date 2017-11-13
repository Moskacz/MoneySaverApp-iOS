//
//  Logger.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 14.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

enum LogLevel {
    case verbose
    case debug
    case info
    case warning
    case error
}

protocol Logger {
    func log(withLevel level: LogLevel, message: String)
}

class NullLogger: Logger {
    func log(withLevel level: LogLevel, message: String) {}
}
