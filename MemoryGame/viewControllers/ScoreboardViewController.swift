//
//  ScoreboardViewController.swift
//  MemoryGame
//
//  Created by user196210 on 6/1/21.
//

import UIKit
import MapKit
class ScoreboardViewController: UIViewController, MKMapViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var records : [Player]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadRecords()
        print(records!)
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "recordCell")
        tableView.reloadData()
    }
    
    func loadRecords() {
        let preference = myPreference()
        //preference.printAllPlayers()
        self.records = preference.decodeAllPlayers()
        self.records = self.records?.sorted().reversed()
        print(records!)

    }
}

extension ScoreboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records?.count ?? 0
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! TableViewCell
        cell.cell_LBL_playerName.text = records?[indexPath.row].name
        cell.cell_LBL_timeStamp.text = records?[indexPath.row].gameDate
        cell.cell_LBL_gameMode.text = "Game mode: \(String(describing: records?[indexPath.row].getGameMode() ?? GAME_MODE.easy))"
        cell.cell_LBL_moves.text = "\("\(String(describing: records?[indexPath.row].moves ?? -1))")"
        return cell
    }
}
