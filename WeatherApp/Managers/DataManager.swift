//
//  DataManager.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/28/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation
import CoreData


// ToDo: - Create and implement Model Protocols
protocol DataManagerProtocol {
    
    func save(data model: OfferModel, in managedContext: NSManagedObjectContext, onError: (Error?) -> Void)
    func retrieveData(from context: NSManagedObjectContext, data: (OfferModel?) -> Void, onError: (Error?) -> Void)
    
}

class DataManager: DataManagerProtocol {
    
    func save(data model: OfferModel, in managedContext: NSManagedObjectContext, onError: (Error?) -> Void) {
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Weather", in: managedContext)!
        let mObject = NSManagedObject(entity: userEntity, insertInto: managedContext) as! Weather
        
        guard
            let currentWeather = model.current,
            let hourlyWeather = model.hourly,
            let dailyWeather = model.daily
            else { return }
        
        var newHourlyWeatherWeatherArray: [WeatherModelData] = []
        var newDailyWeatherWeatherArray: [WeatherModelData] = []
        var newCurrentWeatherWeatherArray: [WeatherModelData] = []
        
        guard let array = currentWeather.weather else { return }
        newCurrentWeatherWeatherArray = array.map { (model) -> WeatherModelData in
            return WeatherModelData(main: model.main, description: model.description, icon: model.icon)
        }
        
        for weather in hourlyWeather {
            guard let array = weather.weather else { return }
            newHourlyWeatherWeatherArray = array.map { (model) -> WeatherModelData in
                return WeatherModelData(main: model.main, description: model.description, icon: model.icon)
            }
        }
        
        for weather in dailyWeather {
            guard let array = weather.weather else { return }
            newDailyWeatherWeatherArray = array.map { (model) -> WeatherModelData in
                return WeatherModelData(main: model.main, description: model.description, icon: model.icon)
            }
        }
        
        let timezone = model.timezone
        let cWeather = CurrentWeatherData(currentWeather, cWeatherModelWeather: newCurrentWeatherWeatherArray)
        let hWeather = HourlyWeatherData(hourlyWeather, hWeatherModelWeather: newHourlyWeatherWeatherArray)
        let dWeather = DailyWeatherData(dailyWeather, dWeatherModelWeather: newDailyWeatherWeatherArray)
        
        mObject.setValue(timezone, forKey: "timezone")
        mObject.setValue(cWeather, forKey: "current")
        mObject.setValue(hWeather, forKey: "hourly")
        mObject.setValue(dWeather, forKey: "daily")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error.userInfo)
            
        }
        
    }
    
    func retrieveData(from context: NSManagedObjectContext, data: (OfferModel?) -> Void, onError: (Error?) -> Void) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        var coreModel: OfferModel?
        
        do {
            let result = try context.fetch(fetchRequest)
            guard let lastResult = result as? [NSManagedObject] else { return }
            let data = lastResult.last
            let timezone = data?.value(forKey: "timezone") as? String
            let cWeather = data?.value(forKey: "current") as? CurrentWeatherData
            let hWeather = data?.value(forKey: "hourly") as? HourlyWeatherData
            let dWeather = data?.value(forKey: "daily") as? DailyWeatherData
            
            guard
                let currentWeather = cWeather?.currentWeather,
                let hourlyWeather = hWeather?.hourlyWeather,
                let dailyWeather = dWeather?.dailyWeather
                else { return }
            
            for dItem in dailyWeather {
                dItem.weather = dWeather?.dailyWeatherModelWeather.map({ (coreItem) -> WeatherModel in
                    return WeatherModel(withCoreItem: coreItem)
                })
            }
            
            for hItem in hourlyWeather {
                hItem.weather = hWeather?.hourlyWeatherModelWeather.map({ (coreItem) -> WeatherModel in
                    return WeatherModel(withCoreItem: coreItem)
                })
            }
            
            currentWeather.weather = hWeather?.hourlyWeatherModelWeather.map({ (coreItem) -> WeatherModel in
                
                return WeatherModel(withCoreItem: coreItem)
            })
            
            coreModel = OfferModel(withCoreItems: timezone, current: currentWeather, hourly: hourlyWeather, daily: dailyWeather)
            
        } catch {
            print("Failed fetch")
            onError(error)
        }
        data(coreModel)
    }
}
