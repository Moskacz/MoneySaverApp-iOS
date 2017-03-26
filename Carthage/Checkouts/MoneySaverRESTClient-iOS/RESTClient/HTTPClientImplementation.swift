//
//  HTTPClientImplementation.swift
//  RESTClient
//
//  Created by Michał Moskała on 15.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import RxSwift

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum ResponseParsingError: Error {
    case couldNotParse
}

public class HTTPClientImplementation: HTTPClient {
    
    private let session: URLSession
    
    init(sessionProvider: URLSessionProvider) {
        self.session = sessionProvider.getSession()
    }
    
    public func performRequest(withParameters parameters: HTTPRequestParameters) -> Observable<[AnyHashable: Any]> {
        return Observable<[AnyHashable: Any]>.create({ (observer: AnyObserver<[AnyHashable: Any]>) -> Disposable in
            let urlRequest = self.request(withParameters: parameters)
            let task = self.session.dataTask(with: urlRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if let requestError = error {
                    observer.onError(requestError)
                    return
                }
                
                if let responseData = data {
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                        if let json = jsonObject as? [AnyHashable: Any] {
                            observer.onNext(json)
                            observer.onCompleted()
                        } else {
                            observer.onError(ResponseParsingError.couldNotParse)
                        }
                    } catch {
                        observer.onError(error)
                    }
                } else {
                    observer.onError(ResponseParsingError.couldNotParse)
                }
                
            })
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        })
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
