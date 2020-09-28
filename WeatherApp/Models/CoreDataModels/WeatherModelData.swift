//
//  WeatherModelData.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/28/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

public class WeatherModelData: NSObject, NSCoding {
    
    var main: String?
    var weatherDescription: String?
    var icon: String?
 
    enum Key: String {
        
        case main = "main"
        case description = "description"
        case icon = "icon"
        
    }

    init(main: String?, description: String?, icon: String?) {
        
        self.main = main
        self.weatherDescription = description
        self.icon = icon
        
    }

    public override init() {
        
        super.init()
        
    }

    public func encode(with coder: NSCoder) {
        
        coder.encode(main, forKey: Key.main.rawValue)
        coder.encode(weatherDescription, forKey: Key.description.rawValue)
        coder.encode(icon, forKey: Key.icon.rawValue)
        
    }

    public required convenience init?(coder: NSCoder) {
        
        let wMain = coder.decodeObject(forKey: Key.main.rawValue) as? String
        let wDescription = coder.decodeObject(forKey: Key.description.rawValue) as? String
        let wIcon = coder.decodeObject(forKey: Key.icon.rawValue) as? String
        
        self.init(main: wMain, description: wDescription, icon: wIcon)
        
    }
    
}
