//
//  StopButton.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 30.01.21.
//

import Cocoa

class StopButton: NSButton {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func awakeFromNib() {
         super.awakeFromNib()
        let maskUp = NSEvent.EventTypeMask.leftMouseUp.rawValue
        let maskDown = NSEvent.EventTypeMask.leftMouseDown.rawValue
        let mask = Int( maskUp | maskDown ) // cast from UInt
        //shortest way for the above:
        //let mask = NSEvent.EventTypeMask(arrayLiteral: [.leftMouseUp, .leftMouseDown]).rawValue
        self.sendAction(on: NSEvent.EventTypeMask(rawValue: NSEvent.EventTypeMask.RawValue(mask)))
        //objC gives: [self.button sendActionOn: NSLeftMouseDownMask | NSLeftMouseUpMask];
    }
    
}
