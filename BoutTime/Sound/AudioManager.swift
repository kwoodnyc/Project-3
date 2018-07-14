//
//  AudioManager.swift
//  BoutTime
//
//  Created by Kristopher Wood on 7/12/18.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//

import AudioToolbox

class AudioManager {
    var rightAnswerSound: SystemSoundID = 0
    var wrongAnswerSound: SystemSoundID = 1
    
    init () {
        loadSounds()
    }
    
    func loadSounds() {
        var pathToSoundFile = Bundle.main.path(forResource: "CorrectDing", ofType: "wav")
        var soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &rightAnswerSound)
        
        pathToSoundFile = Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")
        soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongAnswerSound)
    }
    
    // MARK: Methods to play sounds
    func playRightAnswerSound() {
        AudioServicesPlaySystemSound(rightAnswerSound)
    }
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongAnswerSound)
    }
}
