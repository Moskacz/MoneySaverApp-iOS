//
//  HTTPRequestParameters.swift
//  RESTClient
//
//  Created by Michał Moskała on 15.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

public struct HTTPRequestParameters {
    let url: URL
    let method: HTTPMethod
    let parameters: [AnyHashable: Any]?
}
