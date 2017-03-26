//
//  TransactionsRouter.swift
//  RESTClient
//
//  Created by Michał Moskała on 23.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

class TransactionsRouter: Router {
    
    let baseURL: URL
    let pathComponent = "transactions"
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func getAllURL() -> URL {
        return baseURL.appendingPathComponent(pathComponent, isDirectory: false)
    }
    
    func postURL(entityID identifier: String) -> URL {
        let url = baseURL.appendingPathComponent(pathComponent, isDirectory: true)
        return url.appendingPathComponent(identifier, isDirectory: false)
    }
    
    func putURL(entityID identifier: String) -> URL {
        let url = baseURL.appendingPathComponent(pathComponent, isDirectory: true)
        return url.appendingPathComponent(identifier, isDirectory: false)
    }
    
    func deleteURL(entityID identifier: String) -> URL {
        let url = baseURL.appendingPathComponent(pathComponent, isDirectory: true)
        return url.appendingPathComponent(identifier, isDirectory: false)
    }
}
