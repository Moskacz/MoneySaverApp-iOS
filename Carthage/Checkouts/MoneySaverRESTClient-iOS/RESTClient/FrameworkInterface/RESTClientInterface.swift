//
//  File.swift
//  RESTClient
//
//  Created by Michał Moskała on 23.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

public class RESTClientInterface {
    
    private let baseURL: URL
    private let httpClient: HTTPClient
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
        self.httpClient = HTTPClientImplementation(sessionProvider: URLSessionProviderImplementation())
    }
    
    public func transactionsRESTClient() -> TransactionsRESTClient {
        let mapper = TransactionFromRESTResponseMapper()
        let router = TransactionsRouter(baseURL: baseURL)
        return TransactionsRESTClientImplementation(httpClient: httpClient,
                                                    mapper: mapper,
                                                    router: router)
    }
}
