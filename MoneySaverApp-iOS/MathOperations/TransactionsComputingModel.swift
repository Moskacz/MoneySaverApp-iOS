//
//  TransactionsComputingModel.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 13.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

protocol TransactionsComputingModel {
    func sumOfAllTransactionsObservable() -> Observable<NSDecimalNumber>
}

class TransactionsComputingModelImpl: TransactionsComputingModel {

    private let coreDataStack: CoreDataStack
    private var fetchedResultsController: NSFetchedResultsController<NSDictionary>?
    private var sumOfAllTransactionsVariable = Variable<NSDecimalNumber>(NSDecimalNumber(string: "0"))
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func sumOfAllTransactionsObservable() -> Observable<NSDecimalNumber> {
        let value = totalValueOfSavedTransactions()
        return Observable.just(value ?? NSDecimalNumber.notANumber)
    }
    
    private func totalValueOfSavedTransactions() -> NSDecimalNumber? {
        let expressionDesc = NSExpressionDescription()
        expressionDesc.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "value")])
        expressionDesc.name = "totalValue"
        expressionDesc.expressionResultType = NSAttributeType.decimalAttributeType
        
        let fetchRequest: NSFetchRequest<NSDictionary> = NSFetchRequest(entityName: "TransactionManagedObject")
        fetchRequest.propertiesToFetch = [expressionDesc]
        fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
        
        do {
            let results = try coreDataStack.getViewContext().fetch(fetchRequest)
            if let result = results.first {
                return result["totalValue"] as? NSDecimalNumber
            }
            return nil
        } catch {
            return nil
        }
    }
}
