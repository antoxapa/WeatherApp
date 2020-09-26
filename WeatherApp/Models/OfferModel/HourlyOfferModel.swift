//
//  HourlyOfferModel.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

class HourlyOfferModel: Codable {
    
    var dt: Double?
    var temp: Float?
    var weather: [WeatherModel]?
    
}
