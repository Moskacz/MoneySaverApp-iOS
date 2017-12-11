//
//  NotificationHandlers.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 10.12.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

class TimeChangedHandler {
    
    private let notificationCenter: NotificationCenter
    private var token: NSObjectProtocol?
    private var handler = {}
    
    init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
    }
    
    func add(handler: @escaping () -> Void) {
        self.handler = handler
        let name = Notification.Name.UIApplicationSignificantTimeChange
        token = notificationCenter.addObserver(forName: name,
                                               object: nil,
                                               queue: .current, using: { [weak self] _ in
            self?.handler()
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
