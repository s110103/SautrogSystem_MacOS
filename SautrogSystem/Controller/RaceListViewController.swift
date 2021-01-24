//
//  RaceListViewController.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 17.01.21.
//

import Cocoa

class RaceListViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    // MARK: - Variables
    var appLocked: Bool = true
    var temporaryRow: Int = 0
    var runs: [String] = ["Sautrogrennen 2021", "Sautrogrennen 2020", "Sautrogrennen 2019"]
    
    // MARK: - Outlets
    @IBOutlet weak var raceListTableView: NSTableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        raceListTableView.delegate = self
        raceListTableView.dataSource = self
        
        raceListTableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.appLockedResult(_:)), name: NSNotification.Name(rawValue: "appLocked"), object: nil)
        
    }
    
    override func viewDidDisappear() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    
    // MARK: - Functions
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 64
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return runs.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
                        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "raceCell"), owner: nil) as? RaceListTableCellView {
            
            cell.raceNameTextField.stringValue = runs[row]
            
            return cell
        }
        
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let table = notification.object as! NSTableView
        
        if temporaryRow != table.selectedRow {
            temporaryRow = table.selectedRow
        }
        
        if table.isRowSelected(table.selectedRow) {
            if appLocked == false {
                
            } else {
                let alert = NSAlert()
                alert.messageText = "Gesperrt"
                alert.informativeText = "Die Software muss zuerst entsperrt werden"
                
                alert.beginSheetModal(for: self.view.window!) { (response) in
                }
            }
            
            table.deselectRow(table.selectedRow)
        }
        
    }
    
    @objc func appLockedResult(_ notification: NSNotification) {
        if let appLockedResult = notification.userInfo?["appLockedResult"] as? Bool {
            appLocked = appLockedResult
        }
    }
    
}
