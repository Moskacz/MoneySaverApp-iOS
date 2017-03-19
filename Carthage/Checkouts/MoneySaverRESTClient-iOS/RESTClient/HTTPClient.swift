//
//  HTTPClient.swift
//  RESTClient
//
//  Created by Michał Moskała on 15.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

typealias HTTPRequestCompletion = (Data?, URLResponse?, Error?) -> Void

protocol HTTPClient {
    func performRequest(withParameters parameters: HTTPRequestParameters,
                        completion: @escaping HTTPRequestCompletion)
}
