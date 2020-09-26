//
//  String + UTCtoLocal.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/25/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

extension Double {
    
    func getHours() -> String {
        
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
        
    }
    
    func getHoursMinutes() -> String {
        
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
        
    }
    
    func unixTimeToWeekday() -> String {
        
        let date = Date(timeIntervalSince1970: self)
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        let weekday = calendar.component(.weekday, from: date) % 7
        return calendar.weekdaySymbols[weekday].firstUppercased
        
    }
    
}
