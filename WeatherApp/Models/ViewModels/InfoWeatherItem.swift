//
//  InfoWeatherItem.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/26/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

struct InfoWeatherItem {
    
    var sunrise: String?
    var sunset: String?
    var clouds: String?
    var humidity: String?
    var windSpeed: String?
    var feelsLike: String?
    var rain: String?
    var pressure: String?
    var visibility: String?
    var uvIndex: String?
    
    init(model: OfferModel) {
        
        guard let currentWeather = model.current else { return }
        sunrise = currentWeather.sunrise?.getHoursMinutes() ?? ""
        sunset = currentWeather.sunset?.getHoursMinutes() ?? ""
        clouds = "\(Int(currentWeather.clouds ?? 0)) %"
        humidity = "\(Int(currentWeather.humidity ?? 0)) %"
        windSpeed = "\(Int(currentWeather.wind_speed ?? 0)) км/ч"
        if let deg = currentWeather.wind_deg {
            windSpeed = "\(deg.direction) \(Int(currentWeather.wind_speed ?? 0)) км/ч"
        }
        feelsLike = "\(Int(currentWeather.feels_like ?? 0))º"
       
        pressure = "\(Int(currentWeather.pressure ?? 0)) гПА"
        visibility = "\(Int(currentWeather.visibility ?? 0) / 1000) км"
        uvIndex = "\(currentWeather.uvi ?? 0)"
        
        guard let dailyWeather = model.daily?.first else { return }
        rain = "\(dailyWeather.rain ?? 0 * 10 ) см"
        
    }
    
}
