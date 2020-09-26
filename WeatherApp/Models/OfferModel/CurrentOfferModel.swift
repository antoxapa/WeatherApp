//
//  ListOfferModel.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

class CurrentOfferModel: Codable {
    
    var dt: Double?
    var temp: Float?
    var sunrise: Double?
    var sunset: Double?
    var feels_like: Float?
    var pressure: Float?
    var humidity: Float?
    var uvi: Float?
    var clouds: Double?
    var visibility: Float?
    var wind_speed: Float?
    var wind_deg: Double?
    var rain: Double?
    
    var weather: [WeatherModel]?
    
}
