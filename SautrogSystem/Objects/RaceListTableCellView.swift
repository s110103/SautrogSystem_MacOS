//
//  RaceListTableCellView.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 18.01.21.
//

import Cocoa

class RaceListTableCellView: NSTableCellView {
    
    // MARK: - Outlets
    @IBOutlet weak var raceDocumentImageView: NSImageView!
    @IBOutlet weak var raceNameTextField: NSTextField!
    @IBOutlet weak var racePathTextField: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
