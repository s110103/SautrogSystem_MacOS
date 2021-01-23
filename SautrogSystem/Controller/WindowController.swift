//
//  WindowController.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 17.01.21.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        self.window?.isMovableByWindowBackground = true
        
        self.window?.standardWindowButton(.miniaturizeButton)?.isHidden = true
        self.window?.standardWindowButton(.zoomButton)?.isHidden = true
        
        let attributedString = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: NSColor.white])
        self.window?.standardWindowButton(.closeButton)?.attributedTitle = attributedString
        
        /*
        self.window?.standardWindowButton(.closeButton)?.wantsLayer = true
        self.window?.standardWindowButton(.closeButton)?.layer?.backgroundColor = NSColor.init(calibratedRed: 1, green: 1, blue: 1, alpha: 0).cgColor
        
        let closeButtonCell = NSCell(textCell: "X")
        self.window?.standardWindowButton(.closeButton)?.cell = closeButtonCell
        */
        
        
    }
}
