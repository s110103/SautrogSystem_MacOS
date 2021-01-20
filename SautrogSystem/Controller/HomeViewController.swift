//
//  WelcomeViewController.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 17.01.21.
//

import Cocoa

class HomeViewController: NSViewController {
    
    // MARK: - Variables
    var appLocked: Bool = true
    
    // MARK: - Outlets
    @IBOutlet weak var versionTextField: NSTextField!
    @IBOutlet weak var addRaceView: NSView!
    @IBOutlet weak var openRaceView: NSView!
    @IBOutlet weak var lockStatusImageView: NSImageView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    // MARK: - Actions
    
    // MARK: - Functions
    override func mouseUp(with event: NSEvent) {
        let touchedPoint: CGPoint = event.locationInWindow
                
        if addRaceView.frame.contains(touchedPoint) {
        }
        
        if openRaceView.frame.contains(touchedPoint) {
        }
        
        if lockStatusImageView.frame.contains(touchedPoint) {
            
            performSegue(withIdentifier: "showLoginSegue", sender: self)
            
            if appLocked == true {
                appLocked = false
                lockStatusImageView.image = NSImage(named: "NSLockUnlockedTemplate")
            } else {
                appLocked = true
                lockStatusImageView.image = NSImage(named: "NSLockLockedTemplate")
            }
        }
        
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showLoginSegue":
            let tel = 0
        default:
            break
        }
    }
    
}
