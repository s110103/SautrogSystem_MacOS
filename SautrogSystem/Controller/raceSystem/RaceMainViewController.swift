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
    var timerHasBegan: Bool = false
    var timerRunning: Bool = false
    var firstTeamName: String?
    var secondTeamName: String?
    var firstTeamID: Int?
    var secondTeamID: Int?
    var winnerTeam: Int?
    var looserTeam: Int?
    var expectClearence: Bool = false
    
    var currentCompetition: Competition?
    
    var currentFirstPopUpTeam: Team?
    var currentSecondPopUpTeam: Team?
    
    var cellHeight: Int = 25
    @objc dynamic var teams: [Team] = []
    
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
    @IBOutlet weak var timerFirstLabel: NSTextField!
    @IBOutlet weak var timerSecondLabel: NSTextField!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newTeamResult(_:)), name: NSNotification.Name(rawValue: "newTeam"), object: nil)
        
        teamListTableView.delegate = self
        teamListTableView.dataSource = self
        
        teamListTableView.registerForDraggedTypes([teamPasteboardType])
        teamListTableView.backgroundColor = NSColor.clear
        
        
        var frame = self.view.window?.frame
        let initialSize = NSSize(width: 1100, height: 450)
        frame?.size = initialSize
        self.view.window?.setFrame(frame!, display: true)
        
        teams.append(Team(_teamID: 1, _teamName: "Team1", _teamFirstDriver: "1 Fahrer 1", _teamSecondDriver: "1 Fahrer 2", _teamSong: "Song 1", _teamCostume: "Kostüm 1", _teamRemarks: "Bemerkungen 1", _teamGender: 0, _teamAnnotations: 0, _teamPayedFee: 0))
        teams.append(Team(_teamID: 2, _teamName: "Team2", _teamFirstDriver: "2 Fahrer 1", _teamSecondDriver: "2 Fahrer 2", _teamSong: "Song 2", _teamCostume: "Kostüm 2", _teamRemarks: "Bemerkungen 2", _teamGender: 0, _teamAnnotations: 0, _teamPayedFee: 0))
        
        teamListTableView.reloadData()
        initPopUpButtons()
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
        let index = sender.indexOfSelectedItem
        
        /*
            Send Socket
         */
        
        currentFirstPopUpTeam = teams[index]
        firstTeamID = index
    }
    @IBAction func timerSecondTeamPopUpTapped(_ sender: NSPopUpButton) {
        let index = sender.indexOfSelectedItem
        
        /*
            Send Socket
         */
        
        currentSecondPopUpTeam = teams[index]
        secondTeamID = index
    }
    @IBAction func timerInitButtonTapped(_ sender: NSButton) {
        /*
            Send Socket to initialize external displays
         */
        
        if currentFirstPopUpTeam != nil && currentSecondPopUpTeam != nil {
            currentCompetition = Competition(_competitionId: getNewUniqueId(), _firstTeam: currentFirstPopUpTeam!, _secondTeam: currentSecondPopUpTeam!, _timeInitiated: NSDate())
        } else {
            let alert = NSAlert()
            alert.messageText = "Fehler"
            alert.informativeText = "Mindestens eines der Teams konnte nicht übertragen werden!"
            alert.runModal()
        }
    }
    @IBAction func timerClearButtonTapped(_ sender: NSButton) {
        /*
            Send Socket to clear external displays
         */
        
        initPopUpButtons()
        timerRunning = false
        timerHasBegan = false
        timer?.invalidate()
        timer = nil
        timeCommenced = nil
        timeFinished = nil
        timeInterval = TimeInterval()
        timerLabel.stringValue = "00:00,000"
        timerFirstLabel.stringValue = "00:00,000"
        timerSecondLabel.stringValue = "00:00,000"
        winnerTeam = nil
        looserTeam = nil
        currentCompetition = nil
        expectClearence = false
        timerStopButton.title = "Stop"
        timerStopFirstButton.title = "Stop 1"
        timerStopSecondButton.title = "Stop 2"
    }
    @IBAction func timerStartButtonTapped(_ sender: NSButton) {
        if expectClearence == false {
            if timerRunning == false {
                timeCommenced = NSDate()
                timeFinished = nil
                timerRunning = true
                
                if timerHasBegan == false {
                    timerHasBegan = true
                }
                
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
                
                if timerStopButton.title == "Reset" {
                    timerStopButton.title = "Stop"
                }
                expectClearence = true
            }
        } else {
            let alert = NSAlert()
            alert.messageText = "Fehler"
            alert.informativeText = "Der Timer muss zuerst mit der Clear Funktion zurückgesetzt werden!"
            alert.runModal()
        }
    }
    @IBAction func timerStopButtonTapped(_ sender: StopButton) {
        
        let currentEvent = NSApp.currentEvent
        
        if currentEvent?.type == .leftMouseDown {
            if timerStopButton.title == "Stop" {
                if timerRunning == true {
                    let now = NSDate()
                    timer?.invalidate()
                    timerRunning = false
                    timeFinished = now
                    
                    var currentTimeInterval: TimeInterval = now.timeIntervalSince(timeCommenced! as Date)
                    currentTimeInterval = currentTimeInterval + timeInterval
                    
                    timerLabel.stringValue = formatTime(interval: currentTimeInterval)
                    
                    timeInterval = currentTimeInterval
                    timerStopButton.title = "Reset"
                }
            } else if timerStopButton.title == "Reset" {
                timerStopButton.title = "Stop"
                timeInterval = TimeInterval()
                timerHasBegan = false
                timeCommenced = nil
                timeFinished = nil
                timerLabel.stringValue = "00:00,000"
            }
        }
    }
    
    @IBAction func timerStopFirstButtonTapped(_ sender: StopButton) {
        
        let currentEvent = NSApp.currentEvent
        
        if currentEvent?.type == .leftMouseDown {
            if timerRunning == true {
                let currentDate: NSDate = NSDate()
                var currentTimeInterval: TimeInterval = currentDate.timeIntervalSince(timeCommenced! as Date)
                currentTimeInterval = currentTimeInterval + timeInterval
                
                /*
                    Send Socket
                 */
                
                if winnerTeam == nil {
                    winnerTeam = 1
                    currentCompetition?.winnerTeam = winnerTeam!
                    currentCompetition?.winnerTimeInterval = currentTimeInterval
                    currentCompetition?.timeWinnerFinished = currentDate
                    timerFirstLabel.stringValue = formatTime(interval: currentTimeInterval)
                    timerStopFirstButton.title = "Stop 2"
                    currentFirstPopUpTeam?.teamRunInterval = currentTimeInterval
                    teams.remove(at: firstTeamID!)
                    teams.insert(currentFirstPopUpTeam!, at: firstTeamID!)
                } else {
                    if looserTeam == nil {
                        if winnerTeam == 1 {
                            looserTeam = 2
                            timerSecondLabel.stringValue = formatTime(interval: currentTimeInterval)
                            currentSecondPopUpTeam?.teamRunInterval = currentTimeInterval
                            teams.remove(at: secondTeamID!)
                            teams.insert(currentSecondPopUpTeam!, at: secondTeamID!)
                        } else {
                            looserTeam = 1
                            timerFirstLabel.stringValue = formatTime(interval: currentTimeInterval)
                            currentFirstPopUpTeam?.teamRunInterval = currentTimeInterval
                            teams.remove(at: firstTeamID!)
                            teams.insert(currentFirstPopUpTeam!, at: firstTeamID!)
                        }
                        currentCompetition?.looserTeam = looserTeam!
                        currentCompetition?.winnerTimeInterval = currentTimeInterval
                        currentCompetition?.timeLooserFinished = currentDate
                        
                        timer?.invalidate()
                        timerRunning = false
                        timerHasBegan = false
                        timeFinished = currentDate
                        timeInterval = currentTimeInterval
                        
                        timerLabel.stringValue = formatTime(interval: currentTimeInterval)
                        timerStopFirstButton.title = "Stop 1"
                        teamListTableView.reloadData()
                    }
                }
            }
        }
    }
    @IBAction func timerStopSecondButtonTapped(_ sender: StopButton) {
        
        let currentEvent = NSApp.currentEvent
        
        if currentEvent?.type == .leftMouseDown {
            if timerRunning == true {
                let currentDate: NSDate = NSDate()
                var currentTimeInterval: TimeInterval = currentDate.timeIntervalSince(timeCommenced! as Date)
                currentTimeInterval = currentTimeInterval + timeInterval
                
                /*
                    Send Socket
                 */
                
                if winnerTeam == nil {
                    winnerTeam = 2
                    currentCompetition?.winnerTeam = winnerTeam!
                    currentCompetition?.winnerTimeInterval = currentTimeInterval
                    currentCompetition?.timeWinnerFinished = currentDate
                    timerSecondLabel.stringValue = formatTime(interval: currentTimeInterval)
                    timerStopSecondButton.title = "Stop 1"
                    currentSecondPopUpTeam?.teamRunInterval = currentTimeInterval
                    teams.remove(at: secondTeamID!)
                    teams.insert(currentSecondPopUpTeam!, at: secondTeamID!)
                } else {
                    if looserTeam == nil {
                        if winnerTeam == 1 {
                            looserTeam = 2
                            timerSecondLabel.stringValue = formatTime(interval: currentTimeInterval)
                            currentSecondPopUpTeam?.teamRunInterval = currentTimeInterval
                            teams.remove(at: secondTeamID!)
                            teams.insert(currentSecondPopUpTeam!, at: secondTeamID!)
                        } else {
                            looserTeam = 1
                            timerFirstLabel.stringValue = formatTime(interval: currentTimeInterval)
                            currentFirstPopUpTeam?.teamRunInterval = currentTimeInterval
                            teams.remove(at: firstTeamID!)
                            teams.insert(currentFirstPopUpTeam!, at: firstTeamID!)
                        }
                        currentCompetition?.looserTeam = looserTeam!
                        currentCompetition?.winnerTimeInterval = currentTimeInterval
                        currentCompetition?.timeLooserFinished = currentDate
                        
                        timer?.invalidate()
                        timerRunning = false
                        timerHasBegan = false
                        timeFinished = currentDate
                        timeInterval = currentTimeInterval
                        
                        timerLabel.stringValue = formatTime(interval: currentTimeInterval)
                        timerStopSecondButton.title = "Stop 2"
                        teamListTableView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: - Functions
    func numberOfRows(in tableView: NSTableView) -> Int {
        teams.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 25
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        teamListTableView.deselectRow(teamListTableView.selectedRow)
    }
    
    @objc func startTimer() {
        if timerRunning == true {
            let now = NSDate()
            var currentTimeInterval: TimeInterval = now.timeIntervalSince(timeCommenced! as Date)
            currentTimeInterval = currentTimeInterval + timeInterval
            
            timerLabel.stringValue = formatTime(interval: currentTimeInterval)
        }
    }
    
    func formatTime(interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60 % 60
        let seconds = Int(interval) % 60
        let milliseconds = Int((interval.truncatingRemainder(dividingBy: 1)) * 1000)
        return String(format: "%02i:%02i:%03i", minutes, seconds, milliseconds)
    }
    
    @objc func newTeamResult(_ notification: NSNotification) {
        if let newTeamResult = notification.userInfo?["newTeamResult"] as? Team {
            teams.append(newTeamResult)
            
            teamListTableView.reloadData()
            initPopUpButtons()
        }
    }
    
    func initPopUpButtons() {
        timerFirstTeamPopUp.removeAllItems()
        timerSecondTeamPopUp.removeAllItems()
                
        for i in teams {
            timerFirstTeamPopUp.addItem(withTitle: i.teamName)
            timerSecondTeamPopUp.addItem(withTitle: i.teamName)
        }
        
        if teams.count == 0 {
            currentFirstPopUpTeam = nil
            currentSecondPopUpTeam = nil
            firstTeamID = -1
            secondTeamID = -1
        } else if teams.count == 1 {
            currentFirstPopUpTeam = teams.first
            currentSecondPopUpTeam = nil
            
            timerFirstTeamPopUp.selectItem(at: 0)
            timerSecondTeamPopUp.title = "-"
            firstTeamID = 0
            secondTeamID = -1
        } else if teams.count >= 2 {
            currentFirstPopUpTeam = teams.first
            currentSecondPopUpTeam = teams[1]
            
            timerFirstTeamPopUp.selectItem(at: 0)
            timerSecondTeamPopUp.selectItem(at: 1)
            firstTeamID = 0
            secondTeamID = 1
        }
    }
    
    func getNewUniqueId() -> Int {
        return 0
    }
}

// MARK: - ReOrder

/*
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
*/
