//
//  HourWeatherCell.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/24/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit

class HourWeatherCell: UICollectionViewCell {
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    func configure(with item: HourWeatherItem) {
        
        timeLabel.text = item.time
        temperatureLabel.text = item.temperature + "º"
        weatherImage.image = UIImage(named: item.iconName)
        
    }
    
}
