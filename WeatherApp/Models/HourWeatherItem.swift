//
//  HourWeatherItem.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/26/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

struct HourWeatherItem {
    
    var time: String
    var temperature: String
    var iconName: String
    
    init(withModel model: HourlyOfferModel) {
        
        time = model.dt?.getHours() ?? ""
        temperature = Int(model.temp ?? 0).description
        iconName = model.weather?.first?.icon ?? ""
        
    }
    
}
