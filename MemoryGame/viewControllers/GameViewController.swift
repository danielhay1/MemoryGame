//
//  GameViewController.swift
//  MemoryGame
//
//  Created by user196210 on 5/12/21.
//

import UIKit

class GameViewController: UIViewController {
    let BLANK_CARD_IMG_NAME = "blank_card"
    var allowClickAction_flag = true
    var gameManager : GameManager!
    @IBOutlet var images_btn: [UIButton]!
    @IBOutlet weak var movesLbl: UILabel!
    var roundBtn1 : UIButton?
    var roundBtn2 : UIButton?
    @IBOutlet weak var timeLbl: UILabel!
    var timer : Timer?
    var counter = 0
    let preference = myPreference()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tags = getAllBtnTags()
        if(!tags.isEmpty) {
            gameManager = GameManager.init(tags: tags)
            timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(timerTic), userInfo: nil, repeats: true)
            print("************** GAME INIT FINISHED **************")
       }
    }
    
    func updateMovesLbl() {
        movesLbl.text = String(gameManager.moves)
    }
    
    func updateBtnImage(btn : UIButton? ,card : Card) {
        if (btn != nil){
            let btn = btn!
            print("btn\(btn.tag) image updated to: \(String(describing: card.visibleImage))")
            btn.setImage(UIImage(named: card.visibleImage), for: .normal)
        }
    }

    func onImageClick(button : UIButton) {
        /**
         Operation appear after card clicked:
         - game manager operate round and behave in accordance to start or end round (update card image and set button image)
         - game manager operate endround method to flip back the card or keep the card fliped (in case of match)
         - Method sleep for 4 sec to let player watch the pair he choose.
         - endround also responseble to return boolean value that sign GameViewController if button images need to be updated    (in case of non match pair we need to flip cards).
         - game manager operate gameFinished to sign GameViewController in case of game finished.
         - if gameFinished return true method handle finish game and move to winnerViewController.
         */
        //button.isEnabled = false
        let tag = button.tag
        if let clickedCard = gameManager.getCardByTag(tag : tag) {
            gameManager.round(card: clickedCard)
            updateBtnImage(btn: button, card: clickedCard)  // update btn image
            if(self.gameManager.isInRound == false) {
                self.roundBtn1 = button
                if(!self.gameManager.endRound()){
                    self.allowClickAction_flag = false
                    print("ALLOW ACTION:\(self.allowClickAction_flag)")

                    let seconds = 1.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                        self.updateBtnImage(btn: self.roundBtn1, card: clickedCard)
                        self.updateBtnImage(btn: self.roundBtn2, card: clickedCard)
                        self.roundBtn1 = nil
                        self.roundBtn2 = nil
                        self.allowClickAction_flag = true
                        print("ALLOW ACTION:\(self.allowClickAction_flag)")
                    }
                    
                }
                print("--------------------------------------\nround\(String(describing: self.gameManager.moves)) finished.\n--------------------------------------")
                self.updateMovesLbl()
                
            } else {
                self.roundBtn2 = button
            }
            if(self.gameManager.gameFinished()) {    // in case of all cards in cardpack are paired
                // game finished change controllerView to winnerViewController.
                
                self.killTimer()
                print ("=======================================\nGame Finished!\nNumber of moves = \(String(describing: self.gameManager.moves))\n=======================================")
                self.savePlayerRecord()
                self.changeViewController()
            }
        }

    }
    
    func imageClick(button : UIButton) {
        let tag = button.tag
        if(gameManager.isInRound) {
            
        } else {
            
        }
        if(self.gameManager.gameFinished()) {    // in case of all cards in cardpack are paired
            // game finished change controllerView to winnerViewController.
            
            self.killTimer()
            print ("=======================================\nGame Finished!\nNumber of moves = \(String(describing: self.gameManager.moves))\n=======================================")
            self.savePlayerRecord()
            self.changeViewController()
        }		

    }
    //TODO: DELETE IF ABOVE METHOD WORKS
    func savePlayerRecord() {
        if let player = preference.decodePlayer(preference_name: preference.currentPlayer){
            player.moves = gameManager.moves
            preference.encodePlayer(player: player, preference_name: preference.currentPlayer)
            var topTen : [Player] = preference.decodeAllPlayers()
            if(topTen.count < 10){
                let key = "\(String(describing: player.name))_\(String(describing: player.gameDate))"
                preference.encodePlayer(player: player, preference_name: key)
                print("new record inserted!")
            } else {
                topTen = topTen.sorted()
                //sort by moves value
                if(player > topTen[0]) {
                    var key = "\(String(describing: topTen[0].name))_\(String(describing: topTen[0].gameDate))"
                    preference.deletePlayerRecord(preference_name: key)
                    key = "\(String(describing: player.name))_\(String(describing: player.gameDate))"
                    preference.encodePlayer(player: player, preference_name: key)
                    print("new record inserted!")
                }
            }
        }
    }
    
    func getAllBtnTags() -> [Int] {
        var tags : [Int] = []
        for image_btn in images_btn {
            tags.append(image_btn.tag)
        }
        return tags
    }
    

    @IBAction func onBButton(sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        print("card "+String(button.tag)+"clicked")
        if(allowClickAction_flag) {
            self.onImageClick(button: button)
        }
    }
    
    func changeViewController() {
        print("Switch to winner view controller...")
        //open gameViewController
        guard let vc = storyboard?.instantiateViewController(identifier: "Winner_vc") as? WinnerViewController else {
            print("failed to get vc from winnerViewController")
            return
        }
        present(vc, animated: true, completion: nil)
    }
    
    //MARK: timer functions
    func killTimer() {
       timer?.invalidate()
       timer = nil
    }

    @objc func timerTic() {
        counter += 1
        let (m,s) = secondsToHoursMinutesSeconds(seconds: counter)
        let timeStr = stringFromTimeInterval(minutes: m,seconds: s)
        self.timeLbl.text = (String(timeStr))
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int) {
      return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func stringFromTimeInterval(minutes: Int, seconds: Int) -> String {
        return String(format: "%02d:%02d", minutes, seconds)
    }

    
}
