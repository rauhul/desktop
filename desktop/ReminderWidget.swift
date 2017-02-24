//
//  ReminderWidget.swift
//  desktop
//
//  Created by Rauhul Varma on 2/12/17.
//  Copyright © 2017 rvarma. All rights reserved.
//

import Cocoa
import EventKit

class ReminderWidget: WidgetController {
    
    let eventStore = EKEventStore()

    override var REFRESH_INTERVAL: TimeInterval { return 15.0 }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    override func willRefreshWidget() {
        super.willRefreshWidget()
        print("Will Refresh Reminders")
    }
    
    override func refreshWidget() {
        willRefreshWidget()
        let status = EKEventStore.authorizationStatus(for: .reminder)
        
        
        
        
        switch (status) {
        case EKAuthorizationStatus.notDetermined:
            requestAccessToReminders()
            
        case EKAuthorizationStatus.authorized:
            
            let predicate = eventStore.predicateForIncompleteReminders(withDueDateStarting: nil, ending: nil, calendars: nil)
            
            eventStore.fetchReminders(matching: predicate) { (reminders) in
                guard let reminders = reminders else { return }
                for reminder in reminders {
                    
                }
            }
            
            
            
            break
            
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            
            break
        }

        didRefreshWidget()
    }
    
    override func didRefreshWidget() {
        super.didRefreshWidget()
        print("Did Refresh Reminders")
    }

    func requestAccessToReminders() {
        eventStore.requestAccess(to: .reminder) { (accessGranted: Bool, error: Error?) in
            
            if accessGranted == true {
                
            } else {
                
            }
        }
    }
    
}
