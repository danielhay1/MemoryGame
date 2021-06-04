//
//  Player.swift
//  MemoryGame
//
//  Created by user196210 on 6/2/21.
//

import Foundation
class Player : Codable{
    var name : String
    var moves : Int
    var gameDate : String
    init(name: String?, moves: Int?) {
        self.name = (name ?? "player")!
        self.moves = (moves ?? -1)
        self.gameDate = Date().getTodayString()
    }
    
    func strMoves () -> String{
        var strMoves = "NA"
        if(moves != -1) {
            strMoves = "\(String(describing: moves))"
        }
        return strMoves
    }
    
    
    public var description: String { return "Player:{name: \(String(describing: name)), number of moves: \((strMoves())), GameEndTime: \(String(describing: self.gameDate))" }

}

extension Player: Comparable {
    static func < (lhs: Player, rhs: Player) -> Bool {
        return lhs.moves < rhs.moves
    }

    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.moves == rhs.moves
    }
}


