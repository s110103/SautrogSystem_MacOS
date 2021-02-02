//
//  RaceWindowController.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 24.01.21.
//

import Cocoa

class RaceWindowController: NSWindowController {
    
    // MARK: - Variables
    var appLocked: Bool = false
    
    // MARK: - Outlets
    @IBOutlet weak var raceToolbar: NSToolbar!
    @IBOutlet weak var racePrint: NSToolbarItem!
    @IBOutlet weak var raceLock: NSToolbarItem!
    
    // MARK: - Lifecycle
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        self.window?.isMovableByWindowBackground = true
        
        racePrint.isEnabled = true
        raceLock.isEnabled = true
    }

    // MARK: - Actions
    @IBAction func printButtonTapped(_ sender: NSToolbarItem) {
    }
    @IBAction func lockButtonTapped(_ sender: NSToolbarItem) {
        if appLocked == false {
            appLocked = true
        } else {
            appLocked = false
        }
        updateLockingImage()
        sendLockingResult(result: appLocked)
    }
    
    // MARK: - Functions
    func updateLockingImage() {
        if appLocked == true {
            raceLock.image = NSImage(named: "NSLockLockedTemplate")
        } else {
            raceLock.image = NSImage(named: "NSLockUnlockedTemplate")
        }
    }
    
    func sendLockingResult(result: Bool) {
        appLocked = result
        NotificationCenter.default.post(name: NSNotification.Name("appLocked"), object: nil, userInfo: ["appLockedResult": result])
        updateLockingImage()
    }
}
