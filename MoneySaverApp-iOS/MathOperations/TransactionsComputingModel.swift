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
import RxCocoa

protocol TransactionsComputingModel {
    func sumOfAllTransactionsObservable() -> Observable<NSDecimalNumber>
}

class TransactionsComputingModelImpl: TransactionsComputingModel {

    private let coreDataStack: CoreDataStack
    private let notificationCenter: NotificationCenter
    private let logger: Logger
    
    init(coreDataStack: CoreDataStack,
         notificationCenter: NotificationCenter,
         logger: Logger) {
        self.coreDataStack = coreDataStack
        self.notificationCenter = notificationCenter
        self.logger = logger
    }
    
    func sumOfAllTransactionsObservable() -> Observable<NSDecimalNumber> {
        let notificationName = Notification.Name.NSManagedObjectContextDidSave
        return notificationCenter.rx.notification(notificationName).map { (_) -> NSDecimalNumber in
            return self.totalValueOfSavedTransactions()
        }.startWith(totalValueOfSavedTransactions())
    }
    
    private func totalValueOfSavedTransactions() -> NSDecimalNumber {
        let expressionDesc = NSExpressionDescription()
        expressionDesc.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "value")])
        expressionDesc.name = "totalValue"
        expressionDesc.expressionResultType = NSAttributeType.decimalAttributeType
        
        let fetchRequest: NSFetchRequest<NSDictionary> = NSFetchRequest(entityName: "TransactionManagedObject")
        fetchRequest.propertiesToFetch = [expressionDesc]
        fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
        
        do {
            let results = try coreDataStack.getViewContext().fetch(fetchRequest)
            if let result = results.first, let totalValue = result["totalValue"] as? NSDecimalNumber {
                return totalValue
            } else {
                return NSDecimalNumber(value: 0.0)
            }
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
            return NSDecimalNumber(value: 0.0)
        }
    }
}
