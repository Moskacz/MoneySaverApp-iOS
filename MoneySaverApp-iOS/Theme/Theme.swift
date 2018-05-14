//
//  Theme.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 13.05.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import MMFoundation
import Chameleon

enum AppColor {
    case main
    case mainDark
    case activeElement
    case activeElementDark
    case green
    case greenDark
    case red
    case redDark
    
    var value: UIColor {
        switch self {
        case .main: return UIColor.flatYellow()
        case .mainDark: return UIColor.flatYellowColorDark()
        case .activeElement: return UIColor.flatBlue()
        case .activeElementDark: return UIColor.flatBlueColorDark()
        case .green: return UIColor.flatGreen()
        case .greenDark: return UIColor.flatGreenColorDark()
        case .red: return UIColor.flatRed()
        case .redDark: return UIColor.flatRedColorDark()
        }
    }
}

enum AppGradient {
    case activeElement
    case positiveValueTransaction
    case negativeValueTransaction
    case summaryView
    case main
    
    var value: Gradient {
        switch self {
        case .activeElement:
            return Gradient(colors: [AppColor.activeElement.value,
                                     AppColor.activeElementDark.value,
                                     AppColor.activeElement.value],
                            direction: .vertical)
            
        case .positiveValueTransaction:
            return Gradient(colors: [AppColor.green.value, AppColor.greenDark.value], direction: .skewRight)
        case .negativeValueTransaction:
            return Gradient(colors: [AppColor.red.value, AppColor.redDark.value], direction: .skewRight)
        case .summaryView:
            return Gradient(colors: [AppColor.main.value, AppColor.mainDark.value], direction: .skewLeft)
        case .main:
            return Gradient(colors: [AppColor.main.value, AppColor.mainDark.value], direction: .skewRight)
        }
    }
}


