//
//  UrlSessionProviderImplementation.swift
//  RESTClient
//
//  Created by Michał Moskała on 15.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

class URLSessionProviderImplementation: URLSessionProvider {
    
    func getSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }
}
