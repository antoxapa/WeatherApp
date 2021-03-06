//
//  DailyOfferModel.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

public class DailyOfferModel: NSObject, NSCoding, Codable {
    
    var dt: Double?
    var temp: TemperatureModel?
    var weather: [WeatherModel]?
    var rain: Float?
    
    enum Key: String {
        
        case dt = "dt"
        case rain = "rain"
        case temp = "temp"
        case weather = "weather"
        
    }
    
    init(dt: Double, rain: Float?, temp: TemperatureModel?, weather: [WeatherModel]) {
        
        self.dt = dt
        self.rain = rain
        self.temp = temp
        self.weather = weather
        
    }
    
    public override init() {
        
        super.init()
        
    }
    
    public func encode(with coder: NSCoder) {
        
        coder.encode(dt, forKey: Key.dt.rawValue)
        coder.encode(rain, forKey: Key.rain.rawValue)
        coder.encode(temp, forKey: Key.temp.rawValue)
        coder.encode(weather, forKey: Key.weather.rawValue)
        
    }
    
    public required convenience init?(coder: NSCoder) {
        
        let ddt = coder.decodeObject(forKey: Key.dt.rawValue) as! Double
        let drain = coder.decodeObject(forKey: Key.rain.rawValue) as? Float
        let dTemp = coder.decodeObject(forKey: Key.temp.rawValue) as? TemperatureModel
        let dWeather = coder.decodeObject(forKey: Key.weather.rawValue) as! [WeatherModel]
        
        self.init(dt: ddt, rain: drain, temp: dTemp, weather: dWeather)
        
    }
    
}
