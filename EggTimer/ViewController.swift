//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var label: UILabel!
    
    let eggTime = ["Soft": 5, "Medium": 7, "Hard": 12]  // Dictionary
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    
    var timer = Timer() // Timer variable

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate() // stop the timer - cancel it
  
        let hardness = sender.currentTitle! // Soft, Medium, Hard
        totalTime = eggTime[hardness]!
        progressBar.progress = 0.0 // initialize the progressBar
        secondsPassed = 0;
        label.text = hardness
        
        // Timer Definition:
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                             target: self,
                             selector: #selector(updateTimer),
                             userInfo: nil,
                             repeats: true)
                    
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            print("\(secondsPassed) seconds.")
            secondsPassed += 1
            let precentageProgress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = precentageProgress
            
        }
        else{
            timer.invalidate() // stop the timer - cancel it
            label.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") // find alarm_sound.mp3" in the application
            player = try! AVAudioPlayer(contentsOf: url!) // find "alarm_sound.mp3" file in the project
            player.play() 

        }
        
    }
    
}
