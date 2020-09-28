//
//  DailyWeatherData.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/28/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

public class DailyWeatherData: NSObject, NSCoding {
    
    public var dailyWeather: [DailyOfferModel]?
    public var dailyWeatherModelWeather: [WeatherModelData]
    
    enum Key: String {
        
        case dailyWeather = "dailyWeather"
        case dailyWeatherModelWeather = "dailyWeatherModelWeather"
        
    }
    
    init(_ dWeather: [DailyOfferModel], dWeatherModelWeather: [WeatherModelData]) {
        
        self.dailyWeather = dWeather
        self.dailyWeatherModelWeather = dWeatherModelWeather
        
    }
    
    public func encode(with coder: NSCoder) {
        
        coder.encode(dailyWeather, forKey: Key.dailyWeather.rawValue)
        coder.encode(dailyWeatherModelWeather, forKey: Key.dailyWeatherModelWeather.rawValue)
        
    }
    
    public required convenience init?(coder: NSCoder) {
        
        let dWeather = coder.decodeObject(forKey: Key.dailyWeather.rawValue) as! [DailyOfferModel]
        let dWeatherModelData = coder.decodeObject(forKey: Key.dailyWeatherModelWeather.rawValue) as! [WeatherModelData]
        
        self.init(dWeather, dWeatherModelWeather: dWeatherModelData)
        
    }
    
}
