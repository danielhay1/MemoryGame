//
//  Game manager.swift
//  MemoryGame
//
//  Created by user196210 on 5/17/21.
//

import Foundation

class GameManager {

    private let CARD_IMG_PRFIX_NAME = "superhero-"
    private let BLANK_CARD_IMG_NAME = "blank_card"
    private let UNIQUE_CARDS_AMOUNT = 8
    private var cardPack : [Card] = []
    private var cardStrImages : [String] = []
    private var tags : [Int]!
    var moves : Int!
    var isInRound : Bool!
    private var roundCard1 : Card?
    private var roundCard2 : Card?
    
    init(tags: [Int]) {
        print("************** INIT GAME MANAGER **************")
        self.tags = tags
        self.moves = 0
        self.initCardPack()
        self.isInRound = false
    }
    
    func initCardPackImages() {
        for _ in 1...2 {
            for i in 1...UNIQUE_CARDS_AMOUNT {
                cardStrImages.append("\(CARD_IMG_PRFIX_NAME)\(i)")
            }
        }
        cardStrImages.shuffle()
        print(cardStrImages)
    }
    
    func initCardPack() {
        self.initCardPackImages() // init strImages
        print("number of cards = \(tags.count)")
        for i in 0 ... tags.count-1 {
            cardPack.append(Card(imageName: cardStrImages[i],tag: tags[i]))
        }
    }
    
    func getCardByTag(tag : Int) -> Card?{
        for card in cardPack {
            if(card.tag == tag && card.isPairFound == false) {
                return card
            }
        }
        return nil
    }

    
    func gameFinished () -> Bool {
        for card in cardPack {
            if (card.isPairFound == false) {
                return false
            }
        }
        return true
    }
    
    func round(card : Card) {
        if(isInRound == false) {
            isInRound = true
            roundCard1 = card
            roundCard1?.flipCard()
        } else {
            roundCard2 = card
            if(roundCard2?.tag != roundCard1?.tag) {
                roundCard2?.flipCard()
                isInRound = false
            } else {
                print("Card already selected!")
            }
        }
    }
    
    func endRound() -> Bool{
        var pairFound = false
        if ((roundCard1 != nil) && (roundCard2 != nil)){
            if(isInRound == false){
                moves += 1  // round ended - moves updates
                pairFound = isPairfound()
                if(!pairFound) {    // flip card image if value
                    self.roundCard1?.flipCard()
                    self.roundCard2?.flipCard()
                }
            }
        }
        return pairFound
    }
    
    func isPairfound() -> Bool{
        if(self.roundCard1 != nil && self.roundCard1 != nil) {
            let c1 = roundCard1!
            let c2 = roundCard2!
            if(c1.isPair(card: c2)) {
                // TODO: check this line working
                // Mark card as pair - means that they are out of the game
                print("pair found!")
                self.roundCard1?.isPairFound = true
                self.roundCard2?.isPairFound = true
                return true
            }
        }
        return false
    }
        
}


    




