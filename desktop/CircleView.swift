//
//  CircleView.swift
//  desktop
//
//  Created by Rauhul Varma on 12/20/16.
//  Copyright © 2016 rvarma. All rights reserved.
//

import Cocoa

class CircleView: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        let path = NSBezierPath()
        path.appendOval(in: bounds)
        NSColor.white.setFill()
        path.fill()
    }
    
}
