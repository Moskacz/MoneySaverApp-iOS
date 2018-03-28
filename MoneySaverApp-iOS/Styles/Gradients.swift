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
    static let activeElement = Gradient(colors: [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)], direction: .skewLeft)
    static let positiveValueTransaction: Gradient = Gradient(colors: [UIColor.green, UIColor.appGreen],
                                                                         direction: .skewRight)
    static let negativeValueTransaction = Gradient(colors: [UIColor.red, UIColor.appRed],
                                                                         direction: .skewRight)
}
