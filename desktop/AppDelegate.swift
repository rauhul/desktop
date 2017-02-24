//
//  AppDelegate.swift
//  desktop
//
//  Created by Rauhul Varma on 12/15/16.
//  Copyright © 2016 rvarma. All rights reserved.
//

import Cocoa
import CoreLocation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        /* set up window size */
        let screen = NSScreen.main()!.frame
        let window = NSApplication.shared().windows.last!
        
        window.setFrame(NSRect(x: DESKTOP_INSET, y: DESKTOP_INSET, width: screen.width - (2 * DESKTOP_INSET), height: screen.height - (2 * DESKTOP_INSET)), display: true)
        window.backgroundColor = NSColor.clear
        window.alphaValue = 1
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {

    }

}

