//
//  RaceUnlockViewController.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 03.02.21.
//

import Cocoa

protocol RaceUnlockViewControllerDelegate {
    func sendUnlockingResult(result: Bool)
}

class RaceUnlockViewController: NSViewController {

    // MARK: - Variables
    var delegate: RaceUnlockViewControllerDelegate?
    var monitor: Any?
    
    // MARK: - Outlets
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var closeButton: NSButton!
    @IBOutlet weak var activateButton: NSButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.monitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown, handler: keyDownEvent)
        
        activateButton.title = "Aktivieren"
        activateButton.bezelStyle = .texturedSquare
        activateButton.isBordered = false
        activateButton.wantsLayer = true
        activateButton.layer?.backgroundColor = NSColor.systemBlue.cgColor
        activateButton.layer?.cornerRadius = 5
        activateButton.bezelColor = .white
        
        let attributedString = NSAttributedString(string: activateButton.title, attributes: [NSAttributedString.Key.foregroundColor: NSColor.white])
        
        activateButton.attributedTitle = attributedString
        
    }
    
    // MARK: - Actions
    @IBAction func closeButtonTapped(_ sender: NSButton) {
        dismiss(self)
    }
    
    @IBAction func activateButtonTapped(_ sender: NSButton) {
        checkPassword()
    }
    
    // MARK: - Functions
    func keyDownEvent(event: NSEvent) -> NSEvent {
        if event.keyCode == 36 {
            checkPassword()
        }
        return event
    }
    
    func checkPassword() {
        var result: Bool = true
        
        if passwordTextField.stringValue == "Sautrog" {
            result = false
        }
        passwordTextField.stringValue = ""
                                        
        NotificationCenter.default.post(name: NSNotification.Name("appLocked"), object: nil, userInfo: ["appLockedResult": result])
        dismiss(self)
    }
    
}
