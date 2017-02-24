//
//  SubDesktopWindow.swift
//  desktop
//
//  Created by Rauhul Varma on 12/15/16.
//  Copyright © 2016 rvarma. All rights reserved.
//

import Foundation
import AppKit

class SubWindowDesktop: NSWindow {
    override init(contentRect: NSRect, styleMask style: NSWindowStyleMask, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: bufferingType, defer: flag)
        level = Int(CGWindowLevelForKey(CGWindowLevelKey.desktopIconWindow))
    }
    
//    override var canBecomeMain: Bool {
//        return false
//    }
//    
//    override var canBecomeKey: Bool {
//        return false
//    }

}
