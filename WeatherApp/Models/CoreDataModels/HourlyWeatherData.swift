//
//  HourlyWeatherData.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/28/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

public class HourlyWeatherData: NSObject, NSCoding {
    
    public var hourlyWeather: [HourlyOfferModel]?
    public var hourlyWeatherModelWeather: [WeatherModelData]
    
    enum Key: String {
        
        case hourlyWeather = "hourlyWeather"
        case hourlyWeatherModelWeather = "hourlyWeatherModelWeather"
        
    }
    
    init(_ hWeather: [HourlyOfferModel], hWeatherModelWeather: [WeatherModelData]) {
        
        self.hourlyWeather = hWeather
        self.hourlyWeatherModelWeather = hWeatherModelWeather
        
    }
    
    public func encode(with coder: NSCoder) {
        
        coder.encode(hourlyWeather, forKey: Key.hourlyWeather.rawValue)
        coder.encode(hourlyWeatherModelWeather, forKey: Key.hourlyWeatherModelWeather.rawValue)
        
    }
    
    public required convenience init?(coder: NSCoder) {
        
        let hWeather = coder.decodeObject(forKey: Key.hourlyWeather.rawValue) as! [HourlyOfferModel]
        let hourlyWeatherModelWeather = coder.decodeObject(forKey: Key.hourlyWeatherModelWeather.rawValue) as! [WeatherModelData]
        
        self.init(hWeather, hWeatherModelWeather: hourlyWeatherModelWeather)
        
    }
    
}
