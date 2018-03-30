import Foundation

class ObservationToken {
    
    private let notificationCenter: NotificationCenter
    private let token: NSObjectProtocol
    
    init(notificationCenter: NotificationCenter, token: NSObjectProtocol) {
        self.notificationCenter = notificationCenter
        self.token = token
    }
    
    deinit {
        notificationCenter.removeObserver(token)
    }
}
