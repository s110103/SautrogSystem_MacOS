//
//  VerticallyCenteredTextFieldCell.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 31.01.21.
//

import Foundation
import Cocoa

class VerticallyCenteredTextFieldCell: NSTextFieldCell {

    override func titleRect(forBounds rect: NSRect) -> NSRect {
        var titleFrame = super.titleRect(forBounds: rect)
        let titleSize = self.attributedStringValue.size()
        titleFrame.origin.y = rect.origin.y + (rect.size.height - titleSize.height) / 2.0
        return titleFrame
    }
    
    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        let titleRect = self.titleRect(forBounds: cellFrame)
        self.attributedStringValue.draw(in: titleRect)
    }
    
}
