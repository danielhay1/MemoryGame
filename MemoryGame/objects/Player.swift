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
    var gameMode : Int
    var lat : Double?
    var lon  : Double?
    
    init(name: String?, moves: Int?, gameMode: Int?) {
        self.gameMode = gameMode ?? 0
        self.name = name ?? "player"
        self.moves = moves ?? -1
        self.gameDate = Date().getTodayString()
    }
    
    func strMoves () -> String{
        var strMoves = "NA"
        if(moves != -1) {
            strMoves = "\(String(describing: moves))"
        }
        return strMoves
    }
    
    func getGameMode() -> GAME_MODE! {
        return GAME_MODE(rawValue: GAME_MODE.RawValue(self.gameMode))
    }
    
    func setLocation(lat : Double, lon : Double) {
        self.lat = lat
        self.lon = lon
        print("\(self.name) location is [\(String(describing: self.lat)),\(String(describing: self.lon))]")
    }
    
    private func printLocation() -> String{
        var strLat = "NA"
        var strLon = "NA"
        if lat != nil{
            strLat = "\(String(describing: self.lat))"
        }
        if lon != nil{
            strLon = "\(String(describing: self.lon))"
        }
        return "[\(strLat),\(strLon)]"
    }
    
    public var description: String { return "Player:{name: \(String(describing: name)), numberOfMoves: \((strMoves())), GameTime: \(String(describing: self.gameDate)), gameMode: \(String(describing: getGameMode() ?? GAME_MODE.easy)), location:[\(printLocation())]" }
    }

//Mark: comparable - by game mode then by moves
//handle BUG!
extension Player: Comparable {
    static func < (lhs: Player, rhs: Player) -> Bool {
        if lhs.gameMode == rhs.gameMode {
            return lhs.moves > rhs.moves
        } else {
            return lhs.gameMode < rhs.gameMode
        }
    }

    static func == (lhs: Player, rhs: Player) -> Bool {
        if(lhs.gameMode == rhs.gameMode) {
            return lhs.moves == rhs.moves
        }
        return false
    }
}


