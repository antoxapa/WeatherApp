//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/25/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

public class WeatherModel: NSObject, NSCoding, Codable {
    
    var main: String?
    var weatherDescription: String?
    var icon: String?
    
    enum Key: String {
        
        case main = "main"
        case weatherDescription = "weatherDescription"
        case icon = "icon"
        
    }
    
    init(main: String, weatherDescription: String, icon: String) {
        
        self.main = main
        self.weatherDescription = weatherDescription
        self.icon = icon
        
    }
    
    public override init() {
        
        super.init()
        
    }
    
    public func encode(with coder: NSCoder) {
        
        coder.encode(main, forKey: Key.main.rawValue)
        coder.encode(weatherDescription, forKey: Key.weatherDescription.rawValue)
        coder.encode(icon, forKey: Key.icon.rawValue)
        
    }
    
    public required convenience init?(coder: NSCoder) {
        
        let wMain = coder.decodeObject(forKey: Key.main.rawValue) as! String
        let wDescr = coder.decodeObject(forKey: Key.weatherDescription.rawValue) as! String
        let wIcon = coder.decodeObject(forKey: Key.icon.rawValue) as! String
        
        self.init(main: wMain, weatherDescription: wDescr, icon: wIcon)
        
    }
    
    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
        case icon
    }

    public required init(from decoder: Decoder) throws {
    
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.main = try? container.decodeIfPresent(String.self, forKey: .main)
        self.weatherDescription = try? container.decodeIfPresent(String.self, forKey: .weatherDescription)
        self.icon = try? container.decodeIfPresent(String.self, forKey: .icon)
        
    }

    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(main, forKey: .main)
        try container.encodeIfPresent(weatherDescription, forKey: .weatherDescription)
        try container.encodeIfPresent(icon, forKey: .icon)
        
    }
    
}
