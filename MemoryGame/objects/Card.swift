//
//  Card.swift
//  MemoryGame
//
//  Created by user196210 on 5/8/21.
//

import Foundation
class Card {
    let BLANK_CARD_IMG_NAME = "blank_card"
    var visibleImage : String
    var imageName: String
    var isFliped : Bool
    var isPairFound : Bool // flag that sign that card is not in game use any more
    var tag : Int
    
    init(imageName: String, tag : Int){
        self.imageName = imageName
        self.tag = tag
        self.visibleImage = BLANK_CARD_IMG_NAME
        self.isFliped = false
        self.isPairFound = false
    }
    
    
    func flipCard() {
        if(!isPairFound) {
            if(!isFliped) {
                self.visibleImage = imageName
            }   else {
                self.visibleImage = BLANK_CARD_IMG_NAME
            }
            isFliped = !isFliped
        } else {
            print("Current card pair already found!")
        }
    
    }
    
    
    func isPair(card: Card) -> Bool {
        if(self.imageName.isEqual(card.imageName)) {
            self.isPairFound = true
            return true
        }   else {
            return false
        }
    }
    
}
