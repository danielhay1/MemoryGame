//
//  myPreference.swift
//  MemoryGame
//
//  Created by user196210 on 6/2/21.
//

import Foundation
class myPreference {
    let playerPreferencePrefix = "player_"
    let currentPlayer = "current_player"
    
    // MARK: player codable functions
    func encodePlayer(player: Player, preference_name: String) {
        var key = preference_name
        if preference_name != currentPlayer {
            key = playerPreferencePrefix + preference_name
        }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(player)
        let temp : String = String(data: data, encoding: .utf8)!
        UserDefaults.standard.setValue(temp, forKey: key)
        print("EncodePlayer: \(player.description) saved in key: \(key)")
    }
    
    func decodePlayer (preference_name: String) -> Player? {
        var key = playerPreferencePrefix + preference_name
        if preference_name == currentPlayer {
            key = preference_name
        }
        if let safeJsonPlayer = UserDefaults.standard.string(forKey: key)  {
            let decoder = JSONDecoder()
            let data = Data(safeJsonPlayer.utf8)
            do {
                let player = try decoder.decode(Player.self, from: data)
                print("decodePlayer: \(player.description)")
                return player
            } catch{}
        }
        return nil
    }
    
    
    func decodeAllPlayers() -> [Player] {
        var players = [Player]()
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            if(key.contains(playerPreferencePrefix)) {  // recieve players keys
                let key = key.substring(from: playerPreferencePrefix.length)
                if let player = decodePlayer(preference_name: key){
                    players.append(player)
                }
            }
        }
        return players
    }
        
    func deletePlayerRecord(preference_name:String) {
        UserDefaults.standard.removeObject(forKey: playerPreferencePrefix+preference_name)
        print("Player deleted!")
    }
    
    func deleteAllPlayersRecord() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            if(key.contains(playerPreferencePrefix)) {
                defaults.removeObject(forKey: key)
            }
        }
        print("All players deleted!")
    }
    
    func deleteAllPreference() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
                defaults.removeObject(forKey: key)
        }
        print("All preference deleted!")
    }
    
    func printAllPlayers() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        var count = 0
        print("**************PRINTING ALL PLAYERS:**************)")
        dictionary.keys.forEach { key in
            if(key.hasPrefix(playerPreferencePrefix)) {
                print(defaults.value(forKey: key) ?? "NA")
                count += 1
            }
        }
        print("total number of records:\(count)")
    }
    
    func printMyPreference() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        print("**************PRINTING MYPREFERENCE:**************")
        dictionary.keys.forEach { key in
            print(defaults.value(forKey: key) ?? "NA")
        }
    }

}
