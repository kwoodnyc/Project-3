//
//  ScoreViewController.swift
//  BoutTime
//
//  Created by Kristopher Wood  on 7/12/18.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    
    var userScore: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let score = userScore else {
            fatalError("Cannot Find Score")
        }

        scoreLabel.text = score
    }
    
    @IBAction func playAgainButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: nil)
    }
}
