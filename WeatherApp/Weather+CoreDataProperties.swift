//
//  Weather+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/28/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var current: CurrentWeatherData?
    @NSManaged public var daily: NSObject?
    @NSManaged public var hourly: NSObject?
    @NSManaged public var timezone: String?

}
