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
        
        initObjects()
    }
            
    // MARK: - Actions
    @IBAction func addTeamButtonTapped(_ sender: NSButton) {
        if (teamNameTextField.stringValue == "") || (firstDriverTextField.stringValue == "") || (secondDriverTextField.stringValue == "") || (teamSongTextField.stringValue == "") || (teamCostumeTextField.stringValue == "") || (teamRemarksTextField.stringValue == "") {
            
            let alert = NSAlert()
            
            alert.messageText = "Unvollständig"
            alert.informativeText = "Es fehlen weitere Daten um das Team eindeutig differenzieren zu können!"
            
            alert.addButton(withTitle: "Trotzdem hinzufügen")
            alert.addButton(withTitle: "Abbrechen")
            
            let modalResult = alert.runModal()
            
            switch modalResult {
            case .alertFirstButtonReturn:
                let newTeam = Team(_teamID: getNewUniqueID(), _teamName: teamNameTextField.stringValue, _teamFirstDriver: firstDriverTextField.stringValue, _teamSecondDriver: secondDriverTextField.stringValue, _teamSong: teamSongTextField.stringValue, _teamCostume: teamCostumeTextField.stringValue, _teamRemarks: teamRemarksTextField.stringValue, _teamGender: teamGenderPopUp.indexOfSelectedItem, _teamAnnotations: teamAnnotationsPopUp.indexOfSelectedItem, _teamPayedFee: teamPayedFeePopUp.indexOfSelectedItem)
                
                NotificationCenter.default.post(name: NSNotification.Name("newTeam"), object: nil, userInfo: ["newTeamResult": newTeam])
                resetInputs()
            case .alertSecondButtonReturn:
                break
            default:
                break
            }
            
            
        } else {
            let newTeam = Team(_teamID: getNewUniqueID(), _teamName: teamNameTextField.stringValue, _teamFirstDriver: firstDriverTextField.stringValue, _teamSecondDriver: secondDriverTextField.stringValue, _teamSong: teamSongTextField.stringValue, _teamCostume: teamCostumeTextField.stringValue, _teamRemarks: teamRemarksTextField.stringValue, _teamGender: teamGenderPopUp.indexOfSelectedItem, _teamAnnotations: teamAnnotationsPopUp.indexOfSelectedItem, _teamPayedFee: teamPayedFeePopUp.indexOfSelectedItem)
            
            NotificationCenter.default.post(name: NSNotification.Name("newTeam"), object: nil, userInfo: ["newTeamResult": newTeam])
            resetInputs()
        }
    }
    
    // MARK: - Functions
    func initObjects() {
        resetInputs()
        
        teamGenderPopUp.removeAllItems()
        teamGenderPopUp.addItem(withTitle: "Herren")
        teamGenderPopUp.addItem(withTitle: "Damen")
        teamGenderPopUp.addItem(withTitle: "Mixed")
        
        teamAnnotationsPopUp.removeAllItems()
        teamAnnotationsPopUp.addItem(withTitle: "Teilnehmer")
        teamAnnotationsPopUp.addItem(withTitle: "Partner")
        teamAnnotationsPopUp.addItem(withTitle: "Sponsor")
        
        teamPayedFeePopUp.removeAllItems()
        teamPayedFeePopUp.addItem(withTitle: "-")
        teamPayedFeePopUp.addItem(withTitle: "Bezahlt")
    }
    func getNewUniqueID() -> Int {
        return 0
    }
    
    func resetInputs() {
        teamNameTextField.stringValue = ""
        firstDriverTextField.stringValue = ""
        secondDriverTextField.stringValue = ""
        teamSongTextField.stringValue = ""
        teamCostumeTextField.stringValue = ""
        teamRemarksTextField.stringValue = ""
        
        teamGenderPopUp.selectItem(at: 0)
        teamAnnotationsPopUp.selectItem(at: 0)
        teamPayedFeePopUp.selectItem(at: 0)
    }
    
}
