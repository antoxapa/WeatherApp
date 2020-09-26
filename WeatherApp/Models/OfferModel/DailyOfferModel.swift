//
//  DailyOfferModel.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

class DailyOfferModel: Codable {
    
    var dt: Double?
    var temp: TemperatureModel?
    var weather: [WeatherModel]?
    var rain: Float?
    
}