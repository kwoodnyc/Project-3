//
//  Timer.swift
//  BoutTime
//
//  Created by Kristopher Wood on 7/12/18.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//

import GameKit

protocol Counter {
    var interval: Double { get }
    
    var timer: Timer! { get set }
    var timerActive: Bool { get set }
    
    var currentSeconds: Int { get set }
    var totalSeconds: Int { get }
    
    func runTimerWith(selector: Selector, onObject object: Any)
    func cancelTimer()
}

class GameTimer: Counter {
    let interval: Double = 1
    
    weak var timer: Timer!
    var timerActive: Bool = false
    
    var currentSeconds: Int = 60
    let totalSeconds: Int = 60
    
    func runTimerWith(selector: Selector, onObject object: Any) {
        if !timerActive {
            timer = Timer.scheduledTimer(timeInterval: interval, target: object, selector: selector, userInfo: nil, repeats: true)
            timerActive = true
        }
    }
    
    func cancelTimer() {
        if timerActive {
            currentSeconds = totalSeconds
        
            timer.invalidate()
            timerActive = false
        }
    }
}
