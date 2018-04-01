//
//  Gradients.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 27.03.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import MMFoundation

class Gradients {
    static let activeElement = Gradient(colors: [UIColor.appOrange,
                                                 UIColor.appRed,
                                                 UIColor.appOrange],
                                        direction: .vertical)
    
    static let positiveValueTransaction: Gradient = Gradient(colors: [UIColor.green, UIColor.appGreen],
                                                                         direction: .skewRight)
    
    static let negativeValueTransaction = Gradient(colors: [UIColor.red, UIColor.appRed],
                                                                         direction: .skewRight)
    
    static let summaryViewBackground = Gradient(colors: [UIColor.appGreen, UIColor.appOrange],
                                                direction: .skewLeft)
}
