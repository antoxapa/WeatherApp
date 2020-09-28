//
//  WeekdayWeatherItem.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/26/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

struct WeekdayWeatherItem {
    
    var weekday: String
    var weatherImage: String
    var rainPercents: String?
    var dayTemperature: String
    var nightTemperature: String
    
    init(withModel model: DailyOfferModel) {
        
        weekday = model.dt?.unixTimeToWeekday() ?? ""
        weatherImage = model.weather?.first?.icon ?? ""
        rainPercents = ""
        dayTemperature = Int(model.temp?.day ?? 0).description
        nightTemperature = Int(model.temp?.night ?? 0).description
        
    }
    
}
