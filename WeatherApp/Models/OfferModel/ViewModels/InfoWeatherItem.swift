//
//  InfoWeatherItem.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/26/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

struct InfoWeatherItem {
    
    var sunrise: String
    var sunset: String
    var clouds: String
    var humidity: String
    var windSpeed: String
    var feelsLike: String
    var rain: String?
    var pressure: String
    var visibility: String
    var uvIndex: String
    
    init(model: CurrentOfferModel) {
        
        sunrise = model.sunrise?.getHoursMinutes() ?? ""
        sunset = model.sunset?.getHoursMinutes() ?? ""
        clouds = "\(Int(model.clouds ?? 0)) %"
        humidity = "\(Int(model.humidity ?? 0)) %"
        windSpeed = "\(Int(model.wind_speed ?? 0)) км/ч"
        if let deg = model.wind_deg {
            windSpeed = "\(deg.direction) \(Int(model.wind_speed ?? 0)) км/ч"
        }
        feelsLike = "\(Int(model.feels_like ?? 0))º"
        rain = "\(model.rain ?? 0 * 10 ) см"
        pressure = "\(Int(model.pressure ?? 0)) гПА"
        visibility = "\(Int(model.visibility ?? 0) / 1000) км"
        uvIndex = "\(model.uvi ?? 0)"
        
    }
    
}
