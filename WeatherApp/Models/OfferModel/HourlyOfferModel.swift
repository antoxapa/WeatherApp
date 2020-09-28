//
//  HourlyOfferModel.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

public class HourlyOfferModel: NSObject, NSCoding, Codable {

    var dt: Double?
    var temp: Float?
    var weather: [WeatherModel]?

    enum Key: String {

        case dt = "dt"
        case temp = "temp"
        case weather = "weather"

    }

    init(dt: Double, temp: Float, weather: [WeatherModel]) {

        self.dt = dt
        self.temp = temp
        self.weather = weather

    }

    public override init() {

        super.init()

    }

    public func encode(with coder: NSCoder) {

        coder.encode(dt, forKey: Key.dt.rawValue)
        coder.encode(temp, forKey: Key.temp.rawValue)
        coder.encode(weather, forKey: Key.weather.rawValue)

    }
    
    public required convenience init?(coder: NSCoder) {

        let ddt = coder.decodeObject(forKey: Key.dt.rawValue) as! Double
        let dtemp = coder.decodeObject(forKey: Key.temp.rawValue) as! Float
        let dweather = coder.decodeObject(forKey: Key.weather.rawValue) as! [WeatherModel]

        self.init(dt: ddt, temp: dtemp, weather: dweather)

    }

}
