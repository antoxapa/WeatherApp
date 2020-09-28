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
    
    enum Key: String {
        
        case hourlyWeather = "hourlyWeather"
        
    }
    
    init(_ hWeather: [HourlyOfferModel]) {
        
        self.hourlyWeather = hWeather
        
    }
    
    public func encode(with coder: NSCoder) {
        
        coder.encode(hourlyWeather, forKey: Key.hourlyWeather.rawValue)
        
    }
    
    public required convenience init?(coder: NSCoder) {
        
        let hWeather = coder.decodeObject(forKey: Key.hourlyWeather.rawValue) as! [HourlyOfferModel]
        
        self.init(hWeather)
        
    }
    
}
