//
//  WelcomeViewController.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 17.01.21.
//

import Cocoa

class HomeViewController: NSViewController, UnlockViewControllerDelegate {
    
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
        updateLockingImage()
    }
    
    // MARK: - Actions
    
    // MARK: - Functions
    override func mouseUp(with event: NSEvent) {
        let touchedPoint: CGPoint = event.locationInWindow
                
        if addRaceView.frame.contains(touchedPoint) {
            if appLocked == false {
                //let windowController: NSWindowController = NSStoryboard(name: "windowController", bundle: nil).instantiateController(withIdentifier: "windowController") as! NSWindowController
                
                let windowController = WindowController()
                
                windowController.dismissController(self)
                
                performSegue(withIdentifier: "showSautrogSystemSegue", sender: self)
            } else {
                let alert = NSAlert()
                alert.messageText = "Gesperrt"
                alert.informativeText = "Die Software muss zuerst entsperrt werden"
                
                alert.beginSheetModal(for: self.view.window!) { (response) in
                }
            }
        }
        
        if openRaceView.frame.contains(touchedPoint) {
            if appLocked == false {
            } else {
                let alert = NSAlert()
                alert.messageText = "Gesperrt"
                alert.informativeText = "Die Software muss zuerst entsperrt werden"
                
                alert.beginSheetModal(for: self.view.window!) { (response) in
                }
            }
        }
        
        if lockStatusImageView.frame.contains(touchedPoint) {
            if appLocked == true {
                performSegue(withIdentifier: "showLoginSegue", sender: self)
            } else {
                appLocked = true
                updateLockingImage()
            }
        }
        
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showLoginSegue":
            let destinationVC = segue.destinationController as! UnlockViewController
            
            destinationVC.delegate = self
        default:
            break
        }
    }
    
    func updateLockingImage() {
        if appLocked == true {
            lockStatusImageView.image = NSImage(named: "NSLockLockedTemplate")
        } else {
            lockStatusImageView.image = NSImage(named: "NSLockUnlockedTemplate")
        }
    }
    
    func sendLockingResult(result: Bool) {
        appLocked = result
        updateLockingImage()
    }
    
}
