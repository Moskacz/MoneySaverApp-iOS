//
//  NotificationHandlers.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 10.12.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

protocol TimeChangedObserverDelegate: class {
    func timeChanged()
}

protocol TimeChangedObserver: class {
    var delegate: TimeChangedObserverDelegate? { set get }
}

class TimeChangedObserverImpl: TimeChangedObserver {
    
    public weak var delegate: TimeChangedObserverDelegate? {
        didSet {
            if delegate != nil {
                registerForTimeChangedNotificationsIfNeeded()
            }
        }
    }
    
    private let notificationCenter: NotificationCenter
    private var timeChangedObservationToken: NSObjectProtocol?
    
    init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
    }
    
    private func registerForTimeChangedNotificationsIfNeeded() {
        guard timeChangedObservationToken == nil else { return }
        let notificationName = Notification.Name.UIApplicationSignificantTimeChange
        timeChangedObservationToken = notificationCenter.addObserver(forName: notificationName,
                                                                     object: nil,
                                                                     queue: .current, using: { [weak self] _ in
                                                                                self?.delegate?.timeChanged()
        })
    }
    
    private func removeObserver() {
        if let token = timeChangedObservationToken {
            notificationCenter.removeObserver(token)
        }
    }
    
    deinit {
        removeObserver()
    }
    
}
