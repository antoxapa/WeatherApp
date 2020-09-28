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
            topLeftLabel.text = i20n.sunriseLabel
            topRightLabel.text = i20n.sunsetLabel
            bottomLeftLabel.text = item.sunrise
            bottomRightLabel.text = item.sunset
        case 1:
            topLeftLabel.text = i20n.cloudsLabel
            topRightLabel.text = i20n.humidityLabel
            bottomLeftLabel.text = (item.clouds ?? "0") + " " + i20n.precentsString
            bottomRightLabel.text = (item.humidity ?? "0") + " " + i20n.precentsString
        case 2:
            topLeftLabel.text = i20n.windLabel
            topRightLabel.text = i20n.feels_likeLabel
            bottomLeftLabel.text = (item.windSpeed ?? "0") + " " + i20n.kmhString
            bottomRightLabel.text = (item.feelsLike ?? "0") + i20n.degreesString
        case 3:
            topLeftLabel.text = i20n.rainLabel
            topRightLabel.text = i20n.pressureLabel
            bottomLeftLabel.text = (item.rain ?? "0") + " " + i20n.centimetersString
            bottomRightLabel.text = (item.clouds ?? "0") + " " + i20n.HPAString
        case 4:
            topLeftLabel.text = i20n.visibilityLabel
            topRightLabel.text = i20n.uviLabel
            bottomLeftLabel.text = (item.visibility ?? "0") + " " + i20n.kmString
            bottomRightLabel.text = item.uvIndex
        default:
            topLeftLabel.text = ""
            topRightLabel.text = ""
            bottomLeftLabel.text = ""
            bottomRightLabel.text = ""
            
        }
        
    }
    
}
