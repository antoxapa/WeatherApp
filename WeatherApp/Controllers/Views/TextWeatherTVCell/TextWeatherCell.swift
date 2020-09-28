//
//  TextWeatherCell.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/24/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit

class TextWeatherCell: UITableViewCell {

    @IBOutlet weak var weatherTextLabel: UILabel!
    
    func configure(withItem item: TextWeatherItem) {
        
        weatherTextLabel.text = "\(i20n.todayString) \(i20n.now) \(item.weatherDescription). \(i20n.airTemperature) \(item.temperature)\(i20n.degreesString), \(i20n.windSpeed) \(item.windSpeed) \(i20n.kmhString), \(i20n.windString) \(item.windDirection)"
        
    }

}
