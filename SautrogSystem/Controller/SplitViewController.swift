//
//  SplitViewController.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 17.01.21.
//

import Cocoa

class SplitViewController: NSSplitViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var homeSplitView: NSSplitView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    // MARK: - Functions
    override func splitView(_ splitView: NSSplitView, effectiveRect proposedEffectiveRect: NSRect, forDrawnRect drawnRect: NSRect, ofDividerAt dividerIndex: Int) -> NSRect {
        return NSZeroRect
    }
        
}
