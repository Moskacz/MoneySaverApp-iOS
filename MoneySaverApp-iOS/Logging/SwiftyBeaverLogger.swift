//
//  SwiftyBeaverLogger.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 14.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import SwiftyBeaver

class SwiftyBeaverLogger: Logger {
    
    private let logger: SwiftyBeaver.Type
    
    init() {
        logger = SwiftyBeaver.self
        logger.addDestination(ConsoleDestination())
    }
    
    func log(withLevel level: LogLevel, message: String) {
        switch level {
        case .verbose:
            logger.verbose(message)
        case .debug:
            logger.debug(message)
        case .info:
            logger.info(message)
        case .warning:
            logger.warning(message)
        case .error:
            logger.error(message)
        }
    }
    
}
