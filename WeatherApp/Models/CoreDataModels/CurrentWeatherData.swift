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
    
    enum Key: String {
        
        case currentWeather = "currentWeather"
        
    }
    
    init(_ cWeather: CurrentOfferModel) {
        
        self.currentWeather = cWeather
        
    }
    
    public func encode(with coder: NSCoder) {
        
        coder.encode(currentWeather, forKey: Key.currentWeather.rawValue)
        
    }
    
    public required convenience init?(coder: NSCoder) {
        
        let cWeather = coder.decodeObject(forKey: Key.currentWeather.rawValue) as! CurrentOfferModel
        
        self.init(cWeather)
        
    }
    
}
