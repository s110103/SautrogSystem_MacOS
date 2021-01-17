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
    
}
