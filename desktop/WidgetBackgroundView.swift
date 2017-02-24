//
//  WidgetBackgroundView.swift
//  desktop
//
//  Created by Rauhul Varma on 12/18/16.
//  Copyright © 2016 rvarma. All rights reserved.
//

import Cocoa

class WidgetBackgroundView: NSView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
        layer?.masksToBounds = true
        layer?.backgroundColor = WIDGET_BACKGROUND_COLOR
        layer?.cornerRadius    = WIDGET_BORDER_RADIUS
        layer?.borderWidth     = WIDGET_BORDER_WIDTH
        layer?.borderColor     = WIDGET_BORDER_COLOR
    }
}
