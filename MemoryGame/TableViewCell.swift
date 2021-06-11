//
//  TableViewCell.swift
//  MemoryGame
//
//  Created by user196210 on 6/2/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cell_LBL_playerName: UILabel!
    @IBOutlet weak var cell_LBL_gameMode: UILabel!
    @IBOutlet weak var cell_LBL_timeStamp: UILabel!
    @IBOutlet weak var cell_LBL_moves: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
