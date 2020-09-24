//
//  WeekdayCell.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/24/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit

class WeekdayCell: UITableViewCell {

    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var raintPercentsLabel: UILabel!
    @IBOutlet weak var dayTemperatureLabel: UILabel!
    @IBOutlet weak var nightTemperatureLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
