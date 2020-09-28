//
//  WeekdayCell.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/24/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit

class WeekdayCell: UITableViewCell {
    
    @IBOutlet private weak var weekdayLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var rainPercentsLabel: UILabel!
    @IBOutlet private weak var dayTemperatureLabel: UILabel!
    @IBOutlet private weak var nightTemperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with item: WeekdayWeatherItem) {
        
        weekdayLabel.text = item.weekday
        dayTemperatureLabel.text = item.dayTemperature
        nightTemperatureLabel.text = item.nightTemperature
        rainPercentsLabel.text = item.rainPercents
        weatherImage.image = UIImage(named: item.weatherImage)
        
        
    }
    
}
