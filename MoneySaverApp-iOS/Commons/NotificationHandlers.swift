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
    private var timeChangedObservationToken: NSObjectProtocol?
    private var appWillEnterForegroundObservationToken: NSObjectProtocol?
    
    init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
    }
    
    private func registerForNotificationsIfNeeded() {
        registerForTimeChangedNotificationsIfNeeded()
        registerForEnteringForegroundNotificationsIfNeeded()
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
    
    private func registerForEnteringForegroundNotificationsIfNeeded() {
        guard appWillEnterForegroundObservationToken == nil else { return }
        let notificationName = Notification.Name.UIApplicationWillEnterForeground
        appWillEnterForegroundObservationToken = notificationCenter.addObserver(forName: notificationName,
                                                                                object: nil,
                                                                                queue: .current,
                                                                                using: { [weak self] _ in
                                                                                    self?.delegate?.timeChanged()
        })
    }
    
    private func removeObserver() {
        if let token = timeChangedObservationToken {
            notificationCenter.removeObserver(token)
        }
        if let token = appWillEnterForegroundObservationToken {
            notificationCenter.removeObserver(token)
        }
    }
    
    deinit {
        removeObserver()
    }
    
}
