//
//  RaceListViewController.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 17.01.21.
//

import Cocoa

class RaceListViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    // MARK: - Variables
    var runs: [String] = ["Sautrogrennen 2021", "Sautrogrennen 2020"]
    
    // MARK: - Outlets
    @IBOutlet weak var raceListTableView: NSTableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        raceListTableView.delegate = self
        raceListTableView.dataSource = self
        
        raceListTableView.reloadData()
        
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
        
        table.deselectRow(table.selectedRow)
    }
    
}
