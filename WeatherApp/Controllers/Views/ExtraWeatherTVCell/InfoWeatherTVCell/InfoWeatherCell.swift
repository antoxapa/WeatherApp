//
//  InfoWeatherCell.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/24/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit


class InfoWeatherCell: UITableViewCell {

    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var topRightLabel: UILabel!
    @IBOutlet weak var bottomLeftLabel: UILabel!
    @IBOutlet weak var bottomRightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(withIndex index: Int, item: InfoWeatherItem) {
        
        switch index {
        case 0:
            topLeftLabel.text = "ВОСХОД СОЛНЦА"
            topRightLabel.text = "ЗАХОД СОЛНЦА"
            bottomLeftLabel.text = item.sunrise
            bottomRightLabel.text = item.sunset
        case 1:
            topLeftLabel.text = "ОБЛАЧНОСТЬ"
            topRightLabel.text = "ВЛАЖНОСТЬ"
            bottomLeftLabel.text = item.clouds
            bottomRightLabel.text = item.humidity
        case 2:
            topLeftLabel.text = "ВЕТЕР"
            topRightLabel.text = "ОЩУЩАЕТСЯ КАК"
            bottomLeftLabel.text = item.windSpeed
            bottomRightLabel.text = item.feelsLike
        case 3:
            topLeftLabel.text = "ОСАДКИ"
            topRightLabel.text = "ДАВЛЕНИЕ"
            bottomLeftLabel.text = item.rain
            bottomRightLabel.text = item.pressure
        case 4:
            topLeftLabel.text = "ВИДИМОСТЬ"
            topRightLabel.text = "УФ-ИНДЕКС"
            bottomLeftLabel.text = item.visibility
            bottomRightLabel.text = item.uvIndex
        default:
            topLeftLabel.text = ""
            topRightLabel.text = ""
            bottomLeftLabel.text = ""
            bottomRightLabel.text = ""
            
        }
        
    }
    
}
