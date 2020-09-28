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
    
    enum Key: String {
        
        case dailyWeather = "dailyWeather"
        
    }
    
    init(_ dWeather: [DailyOfferModel]) {
        
        self.dailyWeather = dWeather
        
    }
    
    public func encode(with coder: NSCoder) {
        
        coder.encode(dailyWeather, forKey: Key.dailyWeather.rawValue)
        
    }
    
    public required convenience init?(coder: NSCoder) {
        
        let dWeather = coder.decodeObject(forKey: Key.dailyWeather.rawValue) as! [DailyOfferModel]
        
        self.init(dWeather)
        
    }
    
}
