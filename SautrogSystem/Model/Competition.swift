//
//  Competition.swift
//  SautrogSystem
//
//  Created by Lukas Schauer on 30.01.21.
//

import Foundation

class Competition {
    
    var competitionId: Int = -1
    var firstTeam: Team = Team(_teamId: -1)
    var secondTeam: Team = Team(_teamId: -1)
    var timeInitiated: NSDate = NSDate()
    var timeCommenced: NSDate = NSDate()
    var timeWinnerFinished: NSDate = NSDate()
    var timeLooserFinished: NSDate = NSDate()
    var timeCleared: NSDate = NSDate()
    var winnerTimeInterval: TimeInterval = TimeInterval()
    var looserTimeInterval: TimeInterval = TimeInterval()
    var winnerTeam: Int = -1
    var looserTeam: Int = -1
    
    init(_competitionId: Int) {
        competitionId = _competitionId
    }
    
    init(_competitionId: Int, _firstTeam: Team, _secondTeam: Team, _timeInitiated: NSDate) {
        competitionId = _competitionId
        firstTeam = _firstTeam
        secondTeam = _secondTeam
        timeInitiated = _timeInitiated
    }
    
    init(_competitionId: Int, _firstTeam: Team, _secondTeam: Team, _timeInitiated: NSDate, _timeCommenced: NSDate, _timeWinnerFinished: NSDate, _timeLooserFinished: NSDate, _timeCleared: NSDate, _winnerTimeInterval: TimeInterval, _looserTimeInterval: TimeInterval, _winnerTeam: Int, _looserTeam: Int) {
        competitionId = _competitionId
        firstTeam = _firstTeam
        secondTeam = _secondTeam
        timeInitiated = _timeInitiated
        timeCommenced = _timeCommenced
        timeWinnerFinished = _timeWinnerFinished
        timeLooserFinished = _timeLooserFinished
        timeCleared = _timeCleared
        winnerTimeInterval = _winnerTimeInterval
        looserTimeInterval = _looserTimeInterval
        winnerTeam = _winnerTeam
        looserTeam = _looserTeam
    }
    
}
