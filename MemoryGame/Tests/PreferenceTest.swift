//
//  PreferenceTest.swift
//  MemoryGame
//
//  Created by user196210 on 6/9/21.
//

import Foundation
//#MARK: test method file.
func automationAddPlayers(name: String?, moves: Int?, gameMode: Int?) {
    let preference = myPreference()
    let player = Player(name: name, moves: moves, gameMode: gameMode)
    let key = "\(String(describing: player.name))_\(String(describing: player.gameDate))"
    preference.encodePlayer(player: player, preference_name: key)
    print("automation Test Added Player: \(String(describing: name)) succsessfully")
}

func automationAddPlayersByTopTenRule(name: String?, moves: Int?, gameMode: Int?) {
    let preference = myPreference()
    let player = Player(name: name, moves: moves, gameMode: gameMode)
    var topTen : [Player] = preference.decodeAllPlayers()
    if(!topTen.isEmpty) {
        topTen = topTen.sorted()
        print("Amount of players: \(topTen.count), Worse player: \(topTen[0].description)")
    }
    if(topTen.count < 10){
        // If myPreference have less than 10 players
        let key = "\(String(describing: player.name))_\(String(describing: player.gameDate))"
        preference.encodePlayer(player: player, preference_name: key)
        print("new record inserted!")
        topTen.append(player)
    } else {
        //sort by game mode, then by moves value
        if(player > topTen[0]) {
            var key = "\(String(describing: topTen[0].name))_\(String(describing: topTen[0].gameDate))"
            preference.deletePlayerRecord(preference_name: key)
            key = "\(String(describing: player.name))_\(String(describing: player.gameDate))"
            preference.encodePlayer(player: player, preference_name: key)
            print("new record inserted!")
            topTen.append(player)
        }
    }
    print("Nunber of records: \(topTen.count)")
}
