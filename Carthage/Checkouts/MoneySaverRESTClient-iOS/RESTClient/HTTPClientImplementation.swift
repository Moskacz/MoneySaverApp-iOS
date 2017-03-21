//
//  HTTPClientImplementation.swift
//  RESTClient
//
//  Created by Michał Moskała on 15.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public class HTTPClientImplementation: HTTPClient {
    
    private let session: URLSession
    
    init(sessionProvider: URLSessionProvider) {
        self.session = sessionProvider.getSession()
    }
    
    public func performRequest(withParameters parameters: HTTPRequestParameters,
                        completion: @escaping HTTPRequestCompletion) {
        let urlRequest = request(withParameters: parameters)
        session.dataTask(with: urlRequest, completionHandler: completion).resume()
    }
    
    private func request(withParameters parameters: HTTPRequestParameters) -> URLRequest {
        var request = URLRequest(url: parameters.url)
        request.httpMethod = parameters.method.rawValue
        
        if let parameters = parameters.parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                
            }
        }
        
        return request
    }
}
