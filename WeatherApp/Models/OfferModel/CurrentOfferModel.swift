//
//  ListOfferModel.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

public class CurrentOfferModel: NSObject, NSCoding, Codable {
    
    var dt: Double?
    var temp: Float?
    var sunrise: Double?
    var sunset: Double?
    var feels_like: Float?
    var pressure: Float?
    var humidity: Float?
    var uvi: Float?
    var clouds: Double?
    var visibility: Float?
    var wind_speed: Float?
    var wind_deg: Double?
    
    var weather: [WeatherModel]?
    
    enum Key: String {
        
        case dt = "dt"
        case temp = "temp"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case feels_like = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case uvi = "uvi"
        case clouds = "clouds"
        case visibility = "visibility"
        case wind_speed = "wind_speed"
        case wind_deg = "wind_deg"
        case weather = "weather"
        
    }
    
    init(dt: Double, temp: Float, sunrise: Double, sunset: Double, feelsLike: Float, pressure: Float, humidity: Float, uvi: Float, clouds: Double, visibility: Float, windSpeed: Float, windDeg: Double, weather: [WeatherModel]) {
        
        self.dt = dt
        self.temp = temp
        self.sunrise = sunrise
        self.sunset = sunset
        self.feels_like = feelsLike
        self.pressure = pressure
        self.humidity = humidity
        self.uvi = uvi
        self.clouds = clouds
        self.visibility = visibility
        self.wind_speed = windSpeed
        self.wind_deg = windDeg
        self.weather = weather
        
    }
    
    public override init() {
        
        super.init()
        
    }
    
    public func encode(with coder: NSCoder) {
        
        coder.encode(dt, forKey: Key.dt.rawValue)
        coder.encode(temp, forKey: Key.temp.rawValue)
        coder.encode(sunset, forKey: Key.sunset.rawValue)
        coder.encode(sunrise, forKey: Key.sunrise.rawValue)
        coder.encode(feels_like, forKey: Key.feels_like.rawValue)
        coder.encode(pressure, forKey: Key.pressure.rawValue)
        coder.encode(humidity, forKey: Key.humidity.rawValue)
        coder.encode(uvi, forKey: Key.uvi.rawValue)
        coder.encode(clouds, forKey: Key.clouds.rawValue)
        coder.encode(visibility, forKey: Key.visibility.rawValue)
        coder.encode(wind_speed, forKey: Key.wind_speed.rawValue)
        coder.encode(wind_deg, forKey: Key.wind_deg.rawValue)
        coder.encode(weather, forKey: Key.weather.rawValue)
        
    }
    
    public required convenience init?(coder: NSCoder) {
        
        let ddt = coder.decodeObject(forKey: Key.dt.rawValue) as! Double
        let dtemp = coder.decodeObject(forKey: Key.temp.rawValue) as! Float
        let dsunset = coder.decodeObject(forKey: Key.sunset.rawValue) as! Double
        let dsunrise = coder.decodeObject(forKey: Key.sunrise.rawValue) as! Double
        let dfeel = coder.decodeObject(forKey: Key.feels_like.rawValue) as! Float
        let dpressure = coder.decodeObject(forKey: Key.pressure.rawValue) as! Float
        let dhumidity = coder.decodeObject(forKey: Key.humidity.rawValue) as! Float
        let duvi = coder.decodeObject(forKey: Key.uvi.rawValue) as! Float
        let dclouds = coder.decodeObject(forKey: Key.clouds.rawValue) as! Double
        let dvisibility = coder.decodeObject(forKey: Key.visibility.rawValue) as! Float
        let dwindSpeed = coder.decodeObject(forKey: Key.wind_speed.rawValue) as! Float
        let dwindDeg = coder.decodeObject(forKey: Key.wind_deg.rawValue) as! Double
        let dWeather = coder.decodeObject(forKey: Key.weather.rawValue) as! [WeatherModel]
        
        self.init(dt: ddt, temp: dtemp, sunrise: dsunrise, sunset: dsunset, feelsLike: dfeel, pressure: dpressure, humidity: dhumidity, uvi: duvi, clouds: dclouds, visibility: dvisibility, windSpeed: dwindSpeed, windDeg: dwindDeg, weather: dWeather)
        
    }
    
}

