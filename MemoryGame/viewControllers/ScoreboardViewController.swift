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
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
       AppUtility.lockOrientation(.all)
       // Or to rotate and lock
       // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
       
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       
       // Don't forget to reset when view is being removed
       AppUtility.lockOrientation(.portrait)
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadRecords()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "recordCell")
        tableView.reloadData()
        initMapView()   // add records with none nil value of coordinate to mapview
    }
    
    func loadRecords() {
        print("****************** LOADING RECORDS ******************")
        let preference = myPreference()
        //preference.printAllPlayers()
        self.records = preference.decodeAllPlayers()
        self.records = self.records?.sorted().reversed()
    }
    
    func initMapView() {
        //let region = MK
        setRecordsOnMap()
    }
    
    func setRecordMarker(record: Player) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: record.lat!, longitude: record.lon!)
        annotation.title = "\(record.name): record"
        annotation.subtitle = "Game mode:\(String(describing: record.getGameMode())), Moves: \(record.strMoves())"
        mapView.addAnnotation(annotation)
        
        print("mapView added marker to record: \(record.name) - location:[\(String(describing: record.lat)),\(String(describing: record.lon))) is setting on map!]")
    }
    
    func setRecordsOnMap() {
        if let recordList = records {
            for rec in recordList {
                if(rec.lat != nil && rec.lon != nil) {
                    setRecordMarker(record: rec)
                }
            }
        }
        
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
