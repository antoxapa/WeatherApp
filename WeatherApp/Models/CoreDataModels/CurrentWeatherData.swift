//
//  CurrentWeatherData.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/27/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

public class CurrentWeatherData: NSObject, NSCoding {
    
    public var currentWeather: CurrentOfferModel?
    public var currentWeatherModelWeather: [WeatherModelData]
    
    enum Key: String {
        
        case currentWeather = "currentWeather"
        case currentWeatherModelWeather = "currentWeatherModelWeather"
        
    }
    
    init(_ cWeather: CurrentOfferModel, cWeatherModelWeather: [WeatherModelData]) {
        
        self.currentWeather = cWeather
        self.currentWeatherModelWeather = cWeatherModelWeather
        
    }
    
    public func encode(with coder: NSCoder) {
        
        coder.encode(currentWeather, forKey: Key.currentWeather.rawValue)
        coder.encode(currentWeatherModelWeather, forKey: Key.currentWeatherModelWeather.rawValue)
        
    }
    
    public required convenience init?(coder: NSCoder) {
        
        let cWeather = coder.decodeObject(forKey: Key.currentWeather.rawValue) as! CurrentOfferModel
        let cWeatherModelWeather = coder.decodeObject(forKey: Key.currentWeatherModelWeather.rawValue) as! [WeatherModelData]
        
        self.init(cWeather, cWeatherModelWeather: cWeatherModelWeather)
        
    }
    
}
