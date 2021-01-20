//
//  UnlockViewController.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 20.01.21.
//

import Cocoa

protocol UnlockViewControllerDelegate {
    func sendLockingResult(result: Bool)
}

class UnlockViewController: NSViewController {
    
    // MARK: - Variables
    var delegate: UnlockViewControllerDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var passwordTextField: NSTextField!
    @IBOutlet weak var closeButton: NSButton!
    @IBOutlet weak var activateButton: NSButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
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
        dismiss(self)
    }
    
    // MARK: - Functions
    func checkPassword() {
        var result: Bool = false
        
        if passwordTextField.stringValue == "Sautrog" {
            result = true
        }
        passwordTextField.stringValue = ""
        
        delegate?.sendLockingResult(result: result)
    }
    
}
