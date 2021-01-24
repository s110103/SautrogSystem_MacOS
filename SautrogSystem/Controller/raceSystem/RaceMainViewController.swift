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
    
    let teamPasteboardType = NSPasteboard.PasteboardType(rawValue: "teams.team")
    
    // MARK: - Outlets
    @IBOutlet weak var teamListTableView: NSTableView!
    @IBOutlet weak var teamListTableHeaderView: NSTableHeaderView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newTeamResult(_:)), name: NSNotification.Name(rawValue: "newTeam"), object: nil)
        
        teamListTableView.delegate = self
        teamListTableView.dataSource = self
        
        teamListTableView.registerForDraggedTypes([teamPasteboardType])
        
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
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        teamListTableView.deselectRow(teamListTableView.selectedRow)
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

// MARK: - Pasteboard

extension RaceMainViewController {
    // For the source table view
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        let team = teams[row]
        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setString(team.teamName, forType: teamPasteboardType)
        return pasteboardItem
    }
    
    // For the destination table view
        func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
            if dropOperation == .above {
                return .move
            } else {
                return []
            }
        }

        // For the destination table view
        func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
            guard
                let item = info.draggingPasteboard.pasteboardItems?.first,
                let theString = item.string(forType: teamPasteboardType),
                let team = teams.first(where: { $0.teamName == theString }),
                let originalRow = teams.firstIndex(of: team)
                else { return false }

            var newRow = row
            // When you drag an item downwards, the "new row" index is actually --1. Remember dragging operation is `.above`.
            if originalRow < newRow {
                newRow = row - 1
            }

            // Animate the rows
            tableView.beginUpdates()
            tableView.moveRow(at: originalRow, to: newRow)
            tableView.endUpdates()

            // Persist the ordering by saving your data model
            teams.move(from: originalRow, to: newRow)

            return true
            
            
        }
}
