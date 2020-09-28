//
//  TemperatureModel.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

class TemperatureModel: NSObject, NSCoding, Codable {
    
    var day: Float?
    var min: Float?
    var max: Float?
    var night: Float?
    var morn: Float?
    
    
    enum Key: String {
        
        case day = "day"
        case min = "min"
        case max = "max"
        case night = "night"
        case morn = "morn"
        
    }
    
    init(day: Float, min: Float, max: Float, night: Float, morn: Float) {
        
        self.day = day
        self.min = min
        self.max = max
        self.night = night
        self.morn = morn
        
    }
    
    public override init() {
        
        super.init()
        
    }
    
    public func encode(with coder: NSCoder) {
        
        coder.encode(day, forKey: Key.day.rawValue)
        coder.encode(min, forKey: Key.min.rawValue)
        coder.encode(max, forKey: Key.max.rawValue)
        coder.encode(night, forKey: Key.night.rawValue)
        coder.encode(morn, forKey: Key.morn.rawValue)
        
    }
    
    public required convenience init?(coder: NSCoder) {
        
        let tDay = coder.decodeObject(forKey: Key.day.rawValue) as! Float
        let tMin = coder.decodeObject(forKey: Key.min.rawValue) as! Float
        let tMax = coder.decodeObject(forKey: Key.max.rawValue) as! Float
        let tNight = coder.decodeObject(forKey: Key.night.rawValue) as! Float
        let tMorn = coder.decodeObject(forKey: Key.morn.rawValue) as! Float
        
        self.init(day: tDay, min: tMin, max: tMax, night: tNight, morn: tMorn)
        
    }
}
