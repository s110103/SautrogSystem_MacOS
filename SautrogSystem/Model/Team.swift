//
//  Team.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 24.01.21.
//

import Foundation

class Team {
    
    var teamID: Int = 0
    var teamName: String = ""
    var teamFirstDriver: String = ""
    var teamSecondDriver: String = ""
    var teamSong: String = ""
    var teamCostume: String = ""
    var teamRemarks: String = ""
    var teamGender: Int = 0
    var teamAnnotations: Int = 0
    var teamPayedFee: Int = 0
    var teamCommencedRun: NSDate = NSDate()
    var teamFinishedRun: NSDate = NSDate()
    var teamRunInterval: TimeInterval = TimeInterval()
    
    init(_teamID: Int, _teamName: String, _teamFirstDriver: String, _teamSecondDriver: String, _teamSong: String, _teamCostume: String, _teamRemarks: String, _teamGender: Int, _teamAnnotations: Int, _teamPayedFee: Int, _teamCommencedRun: NSDate, _teamFinishedRun: NSDate, _teamRunInterval: TimeInterval) {
        self.teamID = _teamID
        self.teamName = _teamName
        self.teamFirstDriver = _teamFirstDriver
        self.teamSecondDriver = _teamSecondDriver
        self.teamSong = _teamSong
        self.teamCostume = _teamCostume
        self.teamRemarks = _teamRemarks
        self.teamGender = _teamGender
        self.teamAnnotations = _teamAnnotations
        self.teamPayedFee = _teamPayedFee
        self.teamCommencedRun = _teamCommencedRun
        self.teamFinishedRun = _teamFinishedRun
        self.teamRunInterval = _teamRunInterval
    }
    
    init(_teamId: Int) {
        self.teamID = _teamId
    }
    
}
