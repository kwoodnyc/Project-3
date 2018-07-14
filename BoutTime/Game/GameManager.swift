//
//  GameManager.swift
//  BoutTime
//
//  Created by Kristopher Wood on 7/12/18.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//

protocol Playable {
    var eventsInLabels: [Event] { get set }
}

protocol RoundHandler {
    var currentRound: Int { get set }
    var isRoundActive: Bool { get set }
    
    var roundsWon: Int { get set }
    var totalRounds: Int { get set }
    
    var score: String { get }
    
    func nextRound()
    func logRound(won: Bool)
}

protocol Updater {
    func updateEventUpFromPosition(_ originalPosition: Int)
    func updateEventDownFromPosition(_ originalPosition: Int)
}

protocol Resetable {
    func newGame()
}

class GameManager: Playable, RoundHandler, Updater, Resetable {
    var eventsInLabels: [Event] = []
    
    var currentRound: Int = 1
    var isRoundActive: Bool = true
    
    var roundsWon: Int = 0
    var totalRounds: Int = 0
    
    var score: String {
        return "\(roundsWon)/\(totalRounds)"
    }
    
    func newGame() {
        currentRound = 1
        isRoundActive = true
        
        roundsWon = 0
        totalRounds = 0
        
        eventsInLabels = []
    }
    
    func nextRound() {
        currentRound += 1
    }
    
    func logRound(won: Bool) {
        if won {
            roundsWon += 1
        }
        
        totalRounds += 1
    }
    
    
    func updateEventUpFromPosition(_ originalPosition: Int) {
        let newPosition = originalPosition - 1
        
        let movedUp = eventsInLabels[originalPosition]
        let movedDown = eventsInLabels[newPosition]
        
        eventsInLabels[originalPosition] = movedDown
        eventsInLabels[newPosition] = movedUp
    }
    
    func updateEventDownFromPosition(_ originalPosition: Int) {
        let newPosition = originalPosition + 1
        
        let movedDown = eventsInLabels[originalPosition]
        let movedUp = eventsInLabels[newPosition]
        
        eventsInLabels[originalPosition] = movedUp
        eventsInLabels[newPosition] = movedDown
    }
}
