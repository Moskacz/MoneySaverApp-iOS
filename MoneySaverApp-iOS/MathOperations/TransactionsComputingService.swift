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

protocol TransactionsComputingService  {
    var delegate: TransactionsComputingServiceDelegate? { get set }
}

protocol TransactionsComputingServiceDelegate: class {
    func sumUpdated(value: Decimal)
}

class TransactionsComputingServiceImpl: TransactionsComputingService {

    private let coreDataStack: CoreDataStack
    private let notificationCenter: NotificationCenter
    private let logger: Logger
    
    weak var delegate: TransactionsComputingServiceDelegate? {
        didSet {
            startComputation()
        }
    }
    
    init(coreDataStack: CoreDataStack,
         notificationCenter: NotificationCenter,
         logger: Logger) {
        self.coreDataStack = coreDataStack
        self.notificationCenter = notificationCenter
        self.logger = logger
    }
    
    private func startComputation() {
        coreDataStack.getViewContext { (context) in
            self.setupNotificationsObservers(forContext: context)
            self.delegate?.sumUpdated(value: self.totalValueOfSavedTransactions(inContext: context))
        }
    }
    
    private func setupNotificationsObservers(forContext context: NSManagedObjectContext) {
        let notification = Notification.Name.NSManagedObjectContextDidSave
        notificationCenter.addObserver(forName: notification, object: context, queue: OperationQueue.main) { (_) in
            self.delegate?.sumUpdated(value: self.totalValueOfSavedTransactions(inContext: context))
        }
    }
    
    private func totalValueOfSavedTransactions(inContext context: NSManagedObjectContext) -> Decimal {
        let expressionDesc = NSExpressionDescription()
        expressionDesc.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "value")])
        expressionDesc.name = "totalValue"
        expressionDesc.expressionResultType = NSAttributeType.decimalAttributeType
        
        let fetchRequest: NSFetchRequest<NSDictionary> = NSFetchRequest(entityName: "TransactionManagedObject")
        fetchRequest.propertiesToFetch = [expressionDesc]
        fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
        
        do {
            let results = try context.fetch(fetchRequest)
            if let result = results.first, let totalValue = result["totalValue"] as? Decimal {
                return totalValue
            } else {
                return Decimal(0)
            }
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
            return Decimal(0)
        }
    }
}
