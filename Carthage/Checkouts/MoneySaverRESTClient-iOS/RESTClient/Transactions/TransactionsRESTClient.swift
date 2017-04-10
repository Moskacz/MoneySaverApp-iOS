//
//  TransactionsRESTClient.swift
//  RESTClient
//
//  Created by Michał Moskała on 21.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import MoneySaverFoundationiOS
import RxSwift

public protocol TransactionsRESTClient {
    func getTransactions() -> Observable<[Transaction]>
    func postTransaction(withParameters  parameters: [AnyHashable: Any]) -> Observable<Transaction>
    func putTransaction(withIdentifier identifier: String, parameters: [AnyHashable: Any]) -> Observable<Transaction>
    func deleteTransaction(withIdentifier identifier: String) -> Observable<Void>
}

public class TransactionsRESTClientImplementation: TransactionsRESTClient {
    
    private let httpClient: HTTPClient
    private let mapper: Mapper<[AnyHashable:Any], Transaction>
    private let router: Router
    
    init(httpClient: HTTPClient,
         mapper: Mapper<[AnyHashable:Any], Transaction>,
         router: Router) {
        self.httpClient = httpClient
        self.mapper = mapper
        self.router = router
    }
    
    public func getTransactions() -> Observable<[Transaction]> {
        let url = router.getAllURL()
        let requestParameters = HTTPRequestParameters(url: url, method: .get, parameters: nil)
        return httpClient.performRequest(withParameters: requestParameters).map({ (json: [AnyHashable : Any]) -> [Transaction] in
            guard let transactionsJSON = json["transactions"] as? [[AnyHashable: Any]] else {
                return []
            }
            
            return transactionsJSON.flatMap({ (json: [AnyHashable : Any]) -> Transaction? in
                return try? self.mapper.map(fromType: json)
            })
        })
    }
    
    public func postTransaction(withParameters parameters: [AnyHashable : Any]) -> Observable<Transaction> {
        let url = router.postURL()
        let requestParameters = HTTPRequestParameters(url: url, method: .post, parameters: parameters)
        return httpClient.performRequest(withParameters: requestParameters).flatMap({ (json: [AnyHashable : Any]) -> Observable<Transaction> in
            do {
                let transaction = try self.mapper.map(fromType: json)
                return Observable.just(transaction)
            } catch {
                return Observable.error(error)
            }
        })
    }
    
    public func putTransaction(withIdentifier identifier: String, parameters: [AnyHashable : Any]) -> Observable<Transaction> {
        let url = router.putURL(entityID: identifier)
        let requestParameters = HTTPRequestParameters(url: url, method: .put, parameters: parameters)
        return httpClient.performRequest(withParameters: requestParameters).flatMap({ (json: [AnyHashable : Any]) -> Observable<Transaction> in
            do {
                let transaction = try self.mapper.map(fromType: json)
                return Observable.just(transaction)
            } catch {
                return Observable.error(error)
            }
        })
    }
    
    public func deleteTransaction(withIdentifier identifier: String) -> Observable<Void> {
        let url = router.deleteURL(entityID: identifier)
        let requestParameters = HTTPRequestParameters(url: url, method: .delete, parameters: nil)
        return httpClient.performRequest(withParameters: requestParameters).map { _ -> Void in
            return ()
        }
    }
}
