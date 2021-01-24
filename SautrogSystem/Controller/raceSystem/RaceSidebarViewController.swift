//
//  RaceSidebarViewController.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 24.01.21.
//

import Cocoa

class RaceSidebarViewController: NSViewController {
    
    // MARK: - Variables
    
    // MARK: - Outlets
    @IBOutlet weak var newTeamLabel: NSTextField!
    @IBOutlet weak var teamNameTextField: NSTextField!
    @IBOutlet weak var firstDriverTextField: NSTextField!
    @IBOutlet weak var secondDriverTextField: NSTextField!
    @IBOutlet weak var teamSongTextField: NSTextField!
    @IBOutlet weak var teamCostumeTextField: NSTextField!
    @IBOutlet weak var teamRemarksTextField: NSTextField!
    @IBOutlet weak var teamGenderPopUp: NSPopUpButton!
    @IBOutlet weak var teamAnnotationsPopUp: NSPopUpButton!
    @IBOutlet weak var teamPayedFeePopUp: NSPopUpButton!
    @IBOutlet weak var addTeamButton: NSButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    // MARK: - Actions
    @IBAction func addTeamButtonTapped(_ sender: NSButton) {
        
    }
    
    // MARK: - Functions
    func getNewUniqueID() -> Int {
        return 0
    }
    
}
