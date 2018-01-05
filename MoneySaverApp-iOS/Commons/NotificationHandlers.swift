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

class TimeChangedObserver {
    
    public weak var delegate: TimeChangedObserverDelegate? {
        didSet {
            if delegate != nil {
                registerForNotificationsIfNeeded()
            }
        }
    }
    
    private let notificationCenter: NotificationCenter
    private var token: NSObjectProtocol?
    
    init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
    }
    
    private func registerForNotificationsIfNeeded() {
        guard token == nil else { return }
        let name = Notification.Name.UIApplicationSignificantTimeChange
        token = notificationCenter.addObserver(forName: name,
                                               object: nil,
                                               queue: .current, using: { [weak self] _ in
            self?.delegate?.timeChanged()
        })
    }
    
    private func removeObserver() {
        guard let currentToken = token else { return }
        notificationCenter.removeObserver(currentToken)
    }
    
    deinit {
        removeObserver()
    }
    
}
