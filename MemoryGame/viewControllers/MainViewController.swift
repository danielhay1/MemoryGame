//
//  ViewController.swift
//  MemoryGame
//
//  Created by user196210 on 5/1/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var main_BTN_play: CustomButton!

    @IBOutlet weak var main_BTN_scoreboard: CustomButton!
        
    @IBOutlet weak var main_TF_playername: UITextField!
    var preference = myPreference()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func playBtnClicked() {
        print("Play BTN clicked!")
        saveCurrentPlayer(preferenceName: "player_name")
        //open gameViewController
        guard let vc = storyboard?.instantiateViewController(identifier: "Game_vc") as? GameViewController else {
            print("failed to get vc from storyboard")
            return
        }
        present(vc, animated: true, completion: nil)
    }
    
    func saveCurrentPlayer(preferenceName : String) {
        var playerName = main_TF_playername.text
        if playerName == "" {
            playerName = "player"
        }
        let player = Player(name: playerName ,moves: nil)
        preference.encodePlayer(player: player, preference_name: preference.currentPlayer)
    }
    
    
    
    @IBAction func scoreboardBtnClicked() {
        print("Scoreboard BTN clicked!")
        //open scoreboardViewController
        guard let vc = storyboard?.instantiateViewController(identifier: "Scoreboard_vc") as? ScoreboardViewController else {
            print("failed to get vc from storyboard")
            return
        }
        present(vc, animated: true, completion: nil)
    }
    
}



