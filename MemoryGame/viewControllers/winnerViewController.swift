//
//  winnerViewController.swift
//  MemoryGame
//
//  Created by user196210 on 6/1/21.
//

import UIKit

class WinnerViewController: UIViewController {
    let preference = myPreference()
    @IBOutlet weak var movesLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let player : Player = preference.decodePlayer(preference_name: preference.currentPlayer){
            movesLbl.text = "Number of moves: \(String(describing: player.moves))"
        } else {
            movesLbl.text = "Number of moves: NA"
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
