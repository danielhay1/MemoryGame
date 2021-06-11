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
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var preference = myPreference()
    var gameMode = GAME_MODE.easy
    override func viewDidLoad() {
        super.viewDidLoad()
        //for i in 1...10 {
        //    automationAddPlayersByTopTenRule(name: "easypizzy_\(i)", moves: 40, gameMode: GAME_MODE.easy.rawValue)
        //}
        preference.printAllPlayers()
        //preference.deleteAllPlayersRecord()
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
        let player = Player(name: playerName ,moves: nil, gameMode: gameMode.rawValue)
        preference.encodePlayer(player: player, preference_name: preference.currentPlayer)
        print("Starting game: [Gamemode:\(self.gameMode), Player name:\(String(describing: playerName))]" )
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
    
    @IBAction func gameModeSelect(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.gameMode = GAME_MODE.easy.self
        case 1:
            self.gameMode = GAME_MODE.normal.self
        case 2:
            self.gameMode = GAME_MODE.hard.self
        default:
            self.gameMode = GAME_MODE.easy.self
            break;
        }
    }
}



