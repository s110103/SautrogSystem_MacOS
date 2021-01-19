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
        self.window?.titlebarAppearsTransparent = true
        self.window?.isOpaque = false
        self.window?.makeKeyAndOrderFront(nil)
        
        //self.window?.styleMask = .fullSizeContentView
    }
}
