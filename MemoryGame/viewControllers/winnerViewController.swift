
//
//  winnerViewController.swift
//  MemoryGame
//
//  Created by user196210 on 6/1/21.
//

import UIKit

class WinnerViewController: UIViewController {
    let preference = myPreference()
    @IBOutlet weak var winnerVC_Lbl_gameMode: UILabel!
    @IBOutlet weak var winnerVC_Lbl_moves: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let player : Player = preference.decodePlayer(preference_name: preference.currentPlayer){
            winnerVC_Lbl_moves.text = "Number of moves: \(String(describing: player.moves))"
            winnerVC_Lbl_gameMode.text = "Game mode: \(String(describing: player.getGameMode() ?? GAME_MODE.easy))"
        } else {
            winnerVC_Lbl_moves.text = "Number of moves: NA"
        }
    }
    

    @IBAction func onBackHomeBtnClick(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "Main") as? MainViewController else {
            print("failed to get vc from storyboard")
            return
        }
        present(vc, animated: true, completion: nil)
    }
    
}
