//
//  RaceMainViewController.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 24.01.21.
//

import Cocoa

class RaceMainViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    // MARK: - Variables
    var cellHeight: Int = 16
    var teams: [Team] = []
    
    // MARK: - Outlets
    @IBOutlet weak var teamListTableView: NSTableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newTeamResult(_:)), name: NSNotification.Name(rawValue: "newTeam"), object: nil)
        
        teamListTableView.delegate = self
        teamListTableView.dataSource = self
        
        print(teamListTableView.tableColumns.count)
        
    }
    
    override func viewDidDisappear() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    
    // MARK: - Functions
    @objc func newTeamResult(_ notification: NSNotification) {
        if let newTeamResult = notification.userInfo?["newTeamResult"] as? Team {
            teams.append(newTeamResult)
            
            teamListTableView.reloadData()
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        teams.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let colid = tableColumn?.identifier {
            let width = tableColumn?.width
            let formatter = NumberFormatter()
            formatter.usesGroupingSeparator = true
            
            switch colid.rawValue {
            case "teamColumn":
                return makeLabel(teams[row].teamName, width!)
            case "firstDriverColumn":
                return makeLabel(teams[row].teamFirstDriver, width!)
            case "secondDriverColumn":
                return makeLabel(teams[row].teamSecondDriver, width!)
            case "remarksColumn":
                return makeLabel(teams[row].teamRemarks, width!)
            case "songColumn":
                return makeLabel(teams[row].teamSong, width!)
            case "costumeColumn":
                return makeLabel(teams[row].teamCostume, width!)
            case "payedFeeColumn":
                return makeLabel(String(teams[row].teamPayedFee), width!)
            case "genderColumn":
                return makeLabel(String(teams[row].teamGender), width!)
            case "timeIntervalColumn":
                return makeLabel(String(teams[row].teamRunInterval), width!)
            default:
                break
            }
        }
        
        return nil
    }
    
    func makeLabel(_ text: String, _ width: CGFloat, _ align: NSTextAlignment = .left) -> NSTextField {
        let rect = CGRect(x: 0, y: 0, width: Int(width), height: cellHeight);
        let label = NSTextField(frame: rect)
        label.stringValue = text
        label.isEditable = false
        label.isBezeled = false
        label.drawsBackground = false
        
        label.alignment = align
        return label
    }
}
