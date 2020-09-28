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
    func retrieveData(from context: NSManagedObjectContext, completion: @escaping ((Result<OfferModel?, Error>) -> Void))
    
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
        
        let timezone = model.timezone
        let cWeather = CurrentWeatherData(currentWeather)
        let hWeather = HourlyWeatherData(hourlyWeather)
        let dWeather = DailyWeatherData(dailyWeather)
        
        mObject.setValue(timezone, forKey: "timezone")
        mObject.setValue(cWeather, forKey: "current")
        mObject.setValue(hWeather, forKey: "hourly")
        mObject.setValue(dWeather, forKey: "daily")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            onError(error)
            
        }
        
    }
    
    func retrieveData(from context: NSManagedObjectContext, completion: @escaping ((Result<OfferModel?, Error>) -> Void)) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        var coreModel: OfferModel?
        
        do {
            let result = try context.fetch(fetchRequest)
            guard let data = (result as? [NSManagedObject])?.last else {
                completion(.success(nil))
                return
            }
            let timezone = data.value(forKey: "timezone") as? String
            let cWeather = data.value(forKey: "current") as? CurrentWeatherData
            let hWeather = data.value(forKey: "hourly") as? HourlyWeatherData
            let dWeather = data.value(forKey: "daily") as? DailyWeatherData
            
            guard
                let currentWeather = cWeather?.currentWeather,
                let hourlyWeather = hWeather?.hourlyWeather,
                let dailyWeather = dWeather?.dailyWeather
                else {
                    completion(.success(nil))
                    return
            }
            
            coreModel = OfferModel(withCoreItems: timezone, current: currentWeather, hourly: hourlyWeather, daily: dailyWeather)
            
        } catch {
            completion(.failure(error))
        }
        completion(.success(coreModel))
        
    }
    
}
