//
//  HourWeatherCell.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/24/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit

class HourWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
