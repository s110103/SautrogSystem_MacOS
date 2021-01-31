//
//  Team.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 24.01.21.
//

import Foundation

class Team: NSObject {
    
    @objc dynamic var teamID: Int = 0
    @objc dynamic var teamName: String = ""
    @objc dynamic var teamFirstDriver: String = ""
    @objc dynamic var teamSecondDriver: String = ""
    @objc dynamic var teamSong: String = ""
    @objc dynamic var teamCostume: String = ""
    @objc dynamic var teamRemarks: String = ""
    @objc dynamic var teamGender: Int = 0
    @objc dynamic var teamAnnotations: Int = 0
    @objc dynamic var teamPayedFee: Int = 0
    @objc dynamic var teamCommencedRun: NSDate = NSDate()
    @objc dynamic var teamFinishedRun: NSDate = NSDate()
    @objc dynamic var teamRunInterval: TimeInterval = TimeInterval()
    
    init(_teamId: Int) {
        self.teamID = _teamId
    }
    
    init(_teamID: Int, _teamName: String, _teamFirstDriver: String, _teamSecondDriver: String, _teamSong: String, _teamCostume: String, _teamRemarks: String, _teamGender: Int, _teamAnnotations: Int, _teamPayedFee: Int) {
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
    }
    
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
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        return
            lhs.teamID == rhs.teamID &&
            lhs.teamName == rhs.teamName &&
            lhs.teamFirstDriver == rhs.teamSecondDriver &&
            lhs.teamSong == rhs.teamSong &&
            lhs.teamCostume == rhs.teamCostume &&
            lhs.teamRemarks == rhs.teamRemarks &&
            lhs.teamGender == rhs.teamGender &&
            lhs.teamAnnotations == rhs.teamAnnotations &&
            lhs.teamPayedFee == rhs.teamPayedFee &&
            lhs.teamCommencedRun == rhs.teamCommencedRun &&
            lhs.teamFinishedRun == rhs.teamFinishedRun &&
            lhs.teamRunInterval == rhs.teamRunInterval
    }
    
}
