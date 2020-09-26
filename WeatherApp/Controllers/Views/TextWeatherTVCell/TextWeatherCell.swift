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
        
        weatherTextLabel.text = "Сегодня: Сейчас \(item.weatherDescription). Температура воздуха \(item.temperature), скорость ветра \(item.windSpeed)\(item.windDirection)"
        
    }

}
