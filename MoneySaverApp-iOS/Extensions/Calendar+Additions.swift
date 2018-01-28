//
//  Calendar+Additions.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 28.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

extension Calendar.Identifier {
    var stringIdentifier: String {
        switch self {
        case .gregorian:
            return "gregorian"
        case .buddhist:
            return "buddhist"
        case .chinese:
            return "chinese"
        case .coptic:
            return "coptic"
        case .ethiopicAmeteMihret:
            return "ethiopicAmeteMihret"
        case .ethiopicAmeteAlem:
            return "ethiopicAmeteAlem"
        case .hebrew:
            return "hebrew"
        case .iso8601:
            return "iso8601"
        case .indian:
            return "indian"
        case .islamic:
            return "islamic"
        case .islamicCivil:
            return "islamicCivil"
        case .japanese:
            return "japanese"
        case .persian:
            return "persian"
        case .republicOfChina:
            return "republicOfChina"
        case .islamicTabular:
            return "islamicTabular"
        case .islamicUmmAlQura:
            return "islamicUmmAlQura"
        }
    }
}
