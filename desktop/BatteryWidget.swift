//
//  BatteryWidget.swift
//  desktop
//
//  Created by Rauhul Varma on 12/26/16.
//  Copyright © 2016 rvarma. All rights reserved.
//

import Cocoa

class BatteryWidget: WidgetController {
    
    
    override var REFRESH_INTERVAL: TimeInterval { return 15.0 }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func willRefreshWidget() {
        super.willRefreshWidget()
        print("battery will refresh")
    }
    
    override func refreshWidget() {
        willRefreshWidget()
        let blob = IOPSCopyPowerSourcesInfo()
        let list = IOPSCopyPowerSourcesList(blob?.takeRetainedValue())
        print(list?.takeRetainedValue())
        didRefreshWidget()
    }
    
    override func didRefreshWidget() {
        print("battery did refresh")
        super.didRefreshWidget()
    }
}



