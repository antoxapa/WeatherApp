//
//  TextWeatherItem.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/26/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

struct TextWeatherItem {
    
    var weatherDescription: String
    var temperature: String
    var windSpeed: String
    var windDirection: String
    
    init(with model: CurrentOfferModel) {
        
        weatherDescription = model.weather?.first?.description ?? ""
        temperature = "\(Int(model.temp ?? 0))"
        windSpeed = "\(model.wind_speed ?? 0)"
        windDirection = "."
        if let degrees = model.wind_deg {
            windDirection = "\(degrees.direction)."
        }
        
    }
    
}
