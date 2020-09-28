//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/25/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

public class WeatherModel: Codable {
    
    var main: String?
    var description: String?
    var icon: String?
    
    init(withCoreItem item: WeatherModelData) {
        
        self.main = item.main
        self.description = item.weatherDescription
        self.icon = item.icon
        
    }
}
