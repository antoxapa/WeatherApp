//
//  CurrentWeatherItem.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/26/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

struct CurrentWeatherItem {
    
    var locationName: String
    var weatherDescription: String
    var temperature: String
    var maxTemperature: String
    var minTemperature: String
    
    init(withModel model: OfferModel) {
        
        var locationName = ""
        if let slashIndex = model.timezone?.firstIndex(of: "/"), let index = model.timezone?.index(after: slashIndex) {
            locationName = model.timezone?[index...].description ?? ""
        }
        // TODO: - Localize location name
        self.locationName = locationName
        self.weatherDescription = model.current?.weather?.first?.weatherDescription?.firstCapitalized ?? ""
        self.temperature = Int((model.current?.temp ?? 0)).description
        self.maxTemperature = Int(model.daily?.first?.temp?.max ?? 0).description
        self.minTemperature = Int(model.daily?.first?.temp?.min ?? 0).description
        
    }
    
}
