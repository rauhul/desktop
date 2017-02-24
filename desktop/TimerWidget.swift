//
//  TimerWidget.swift
//  desktop
//
//  Created by Rauhul Varma on 12/15/16.
//  Copyright © 2016 rvarma. All rights reserved.
//

import Cocoa

class TimerWidget: WidgetController {
    
    @IBOutlet weak var timeLabel: NSTextField!
    
    let formatter = { () -> DateFormatter in 
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

    override var REFRESH_INTERVAL: TimeInterval { return 15.0 }
    
    override func refreshWidget() {
        willRefreshWidget()
        timeLabel.stringValue = formatter.string(from: Date())
        didRefreshWidget()
    }
}
