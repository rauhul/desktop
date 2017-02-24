//
//  Widget.swift
//  desktop
//
//  Created by Rauhul Varma on 12/15/16.
//  Copyright © 2016 rvarma. All rights reserved.
//

import Cocoa

class WidgetController: NSViewController {
    
    //default refresh time in seconds
    var REFRESH_INTERVAL: TimeInterval { return 10.0 }
    var timer: Timer?
    
    @IBOutlet weak var refreshIndicator: NSProgressIndicator?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        timer = Timer.scheduledTimer(withTimeInterval: REFRESH_INTERVAL, repeats: true) { (_) in
            self.refreshWidget()
        }
        timer?.tolerance = 0.5
    }

    override func viewWillAppear() {
        timer?.fire()
        refreshIndicator?.isDisplayedWhenStopped = false
    }

    func willRefreshWidget() {
        refreshIndicator?.startAnimation(nil)
    }
    
    func refreshWidget() {
        willRefreshWidget()
        didRefreshWidget()
    }
    
    func didRefreshWidget() {
        refreshIndicator?.stopAnimation(nil)
    }

    
}
