//
//  RaceMainViewController.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 24.01.21.
//

import Cocoa

class RaceMainViewController: NSViewController, NSWindowDelegate, NSTableViewDelegate, NSTableViewDataSource {
    
    // MARK: - Variables
    var timeCommenced: NSDate?
    var timeFinished: NSDate?
    var timeInterval: TimeInterval = TimeInterval()
    var timer: Timer?
    var timerRunning: Bool = false
    var firstTeamName: String?
    var secondTeamName: String?
    var firstTeamID: Int?
    var secondTeamID: Int?
    
    var cellHeight: Int = 16
    var teams: [Team] = []
    
    let teamPasteboardType = NSPasteboard.PasteboardType(rawValue: "teams.team")
    
    // MARK: - Outlets
    @IBOutlet weak var teamListTableView: NSTableView!
    @IBOutlet weak var teamListTableHeaderView: NSTableHeaderView!
    @IBOutlet weak var headerLeabel: NSTextField!
    @IBOutlet weak var subHeaderLabel: NSTextField!
    
    /*
        TimerControls
     */
    @IBOutlet weak var timerLabel: NSTextField!
    @IBOutlet weak var timerFirstTeamPopUp: NSPopUpButton!
    @IBOutlet weak var timerSecondTeamPopUp: NSPopUpButton!
    @IBOutlet weak var timerInitButton: NSButton!
    @IBOutlet weak var timerClearButton: NSButton!
    @IBOutlet weak var timerStartButton: NSButton!
    @IBOutlet weak var timerStopButton: NSButton!
    @IBOutlet weak var timerStopFirstButton: NSButton!
    @IBOutlet weak var timerStopSecondButton: NSButton!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newTeamResult(_:)), name: NSNotification.Name(rawValue: "newTeam"), object: nil)
        
        teamListTableView.delegate = self
        teamListTableView.dataSource = self
        
        teamListTableView.registerForDraggedTypes([teamPasteboardType])
        
        
        var frame = self.view.window?.frame
        let initialSize = NSSize(width: 1100, height: 450)
        frame?.size = initialSize
        self.view.window?.setFrame(frame!, display: true)
        
        teams.append(Team(_teamID: 1, _teamName: "Team", _teamFirstDriver: "Team", _teamSecondDriver: "Team", _teamSong: "Team", _teamCostume: "Team", _teamRemarks: "Team", _teamGender: 0, _teamAnnotations: 0, _teamPayedFee: 0))
        teams.append(Team(_teamID: 2, _teamName: "Team2", _teamFirstDriver: "Team2", _teamSecondDriver: "Team2", _teamSong: "Team2", _teamCostume: "Team2", _teamRemarks: "Team2", _teamGender: 0, _teamAnnotations: 0, _teamPayedFee: 0))
        
        teamListTableView.reloadData()
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window?.delegate = self
        self.view.window?.minSize = NSSize(width: 1100, height: 450)
    }
    
    override func viewDidDisappear() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    @IBAction func timerFirstTeamPopUpTapped(_ sender: NSPopUpButton) {
    }
    @IBAction func timerSecondTeamPopUpTapped(_ sender: NSPopUpButton) {
    }
    @IBAction func timerInitButtonTapped(_ sender: NSButton) {
        /*
            Send Socket to initialize external displays
         */
    }
    @IBAction func timerClearButtonTapped(_ sender: NSButton) {
        /*
            Send Socket to clear external displays
         */
    }
    @IBAction func timerStartButtonTapped(_ sender: NSButton) {
        timeCommenced = NSDate()
        timeFinished = nil
        timerRunning = true
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    }
    @IBAction func timerStopButtonTapped(_ sender: NSButton) {
        if timerRunning == true {
            let now = NSDate()
            timer?.invalidate()
            timerRunning = false
            timeFinished = now
            
            var currentTimeInterval: TimeInterval = now.timeIntervalSince(timeCommenced! as Date)
            currentTimeInterval = currentTimeInterval + timeInterval
            
            timerLabel.stringValue = formatTime(interval: currentTimeInterval)
            
            timeInterval = currentTimeInterval
        }
    }
    @IBAction func timerStopFirstButtonTapped(_ sender: NSButton) {
    }
    @IBAction func timerStopSecondButtonTapped(_ sender: NSButton) {
    }
    
    // MARK: - Functions
    @objc func startTimer() {
        if timerRunning == true {
            let now = NSDate()
            var currentTimeInterval: TimeInterval = now.timeIntervalSince(timeCommenced! as Date)
            currentTimeInterval = currentTimeInterval + timeInterval
            
            timerLabel.stringValue = formatTime(interval: currentTimeInterval)
        }
    }
    
    func formatTime(interval: TimeInterval) -> String {
        //let hours = Int(interval) / 3600
        let minutes = Int(interval) / 60 % 60
        let seconds = Int(interval) % 60
        let milliseconds = Int((interval.truncatingRemainder(dividingBy: 1)) * 1000)
        return String(format: "%02i:%02i:%03i", minutes, seconds, milliseconds)
    }
    
    @objc func newTeamResult(_ notification: NSNotification) {
        if let newTeamResult = notification.userInfo?["newTeamResult"] as? Team {
            teams.append(newTeamResult)
            
            teamListTableView.reloadData()
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        teams.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 25
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
        
        let font = NSFont(name: "Arial", size: 16)
        
        label.font = font
        
        return label
    }
}

// MARK: - ReOrder

extension RaceMainViewController {
    
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        let team = teams[row]
        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setString(String(team.teamID), forType: teamPasteboardType)
        return pasteboardItem
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        if dropOperation == .above {
            return .move
        } else {
            return []
        }
    }

    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        
        print(info.draggingPasteboard.pasteboardItems!.first!)
        guard
            let item = info.draggingPasteboard.pasteboardItems?.first,
            let theString = item.string(forType: teamPasteboardType),
            let team = teams.first(where: { $0.teamID == Int(theString) }),
            let originalRow = teams.firstIndex(of: team)
            else { return false }
        
        var newRow = row

        if originalRow < newRow {
            newRow = row - 1
        }

        tableView.beginUpdates()
        tableView.moveRow(at: originalRow, to: newRow)
        tableView.endUpdates()
        
        teams.move(from: originalRow, to: newRow)
        
        print(originalRow)
        print(newRow)

        return true
    }
}
