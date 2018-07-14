//
//  ViewController.swift
//  BoutTime
//
//  Created by Kristopher Wood on 7/12/18.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//

import UIKit

class ViewController: UIViewController {    
    @IBOutlet var eventButtons: [UIButton]!
    @IBOutlet var navigationButtons: [UIButton]!
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var solutionButton: UIButton!
    @IBOutlet weak var informationLabel: UILabel!
    
    let audioManager = AudioManager()
    let gameManager = GameManager()
    let eventManager = EventManager()
    let timer = GameTimer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameManager.newGame()
        eventManager.newGame()
        
        newRound()
    }
    
    
    func newRound() {
        UIUtils.set(interaction: false, for: eventButtons)
        UIUtils.set(interaction: true, for: navigationButtons)
        
        gameManager.isRoundActive = true
        gameManager.eventsInLabels = eventManager.getEventSetFor(round: gameManager.currentRound).eventSet
        
        timer.runTimerWith(selector: #selector(timerTicked), onObject: self)
        timeLeftLabel.isHidden = false
        timeLeftLabel.text = "1:00"
        
        solutionButton.isHidden = true
        informationLabel.text = "Shake to End Round"
        displayEventsOnLabels()
    }
    
    func checkAndDisplayAnswer() {
        UIUtils.set(interaction: true, for: eventButtons)
        UIUtils.set(interaction: false, for: navigationButtons)
        gameManager.isRoundActive = false
        
        timer.cancelTimer()
        timeLeftLabel.isHidden = true
        
        solutionButton.isHidden = false
        informationLabel.text = "Click on Album for More Info"
        
        if eventManager.doesMatchFor(array: gameManager.eventsInLabels, round: gameManager.currentRound) {
            audioManager.playRightAnswerSound()
            solutionButton.setImage(UIImage(named: "next_round_success"), for: .normal)
            gameManager.logRound(won: true)
        } else {
            audioManager.playWrongAnswerSound()
            solutionButton.setImage(UIImage(named: "next_round_fail"), for: .normal)
            gameManager.logRound(won: false)
        }
    }
    
    @objc func timerTicked() {
        if timer.currentSeconds > -1 {
            timeLeftLabel.text = NumberUtils.format(num: timer.currentSeconds)
            timer.currentSeconds -= 1
        } else {
            checkAndDisplayAnswer()
        }
    }
    
    // MARK: UI elements
    
    @IBAction func upButtonTapped(_ sender: UIButton) {
        gameManager.updateEventUpFromPosition(sender.tag)
        displayEventsOnLabels()
    }
    
    @IBAction func downButtonTapped(_ sender: UIButton) {
        gameManager.updateEventDownFromPosition(sender.tag)
        displayEventsOnLabels()
    }
    
    @IBAction func nextRoundTapped(_ sender: Any) {
        if gameManager.currentRound == 6 {
            performSegue(withIdentifier: "toScore", sender: nil)
            return
        }
        
        gameManager.currentRound += 1
        newRound()
    }
    
    @IBAction func eventButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toWebView", sender: sender.tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "toWebView":
                guard let eventIndex = sender as? Int else {
                    return
                }
                
                guard let destinationVC = segue.destination as? WebViewController else {
                    return
                }
                
                destinationVC.webURL = gameManager.eventsInLabels[eventIndex].eventURL
                break
            case "toScore":
                guard let destinationVC = segue.destination as? ScoreViewController else {
                    return
                }
                
                destinationVC.userScore = gameManager.score
                break
            default: return
            }
        }
    }
    
    // MARK: Shake Functions
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake && gameManager.isRoundActive {
            checkAndDisplayAnswer()
        }
    }
    
    // MARK: UI Related Methods
    func displayEventsOnLabels() {
        let currentEvents = gameManager.eventsInLabels
        
        for button in eventButtons {
            button.setTitle(currentEvents[button.tag].eventDescription, for: .normal)
        }
    }
}
