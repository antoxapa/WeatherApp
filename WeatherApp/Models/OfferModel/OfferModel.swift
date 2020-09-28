//
//  OfferModel.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

class OfferModel: Codable {
    
    var timezone: String?
    var current: CurrentOfferModel?
    var hourly: [HourlyOfferModel]?
    var daily: [DailyOfferModel]?
    
    init(withCoreItems timeZone: String?, current: CurrentOfferModel?, hourly: [HourlyOfferModel]?, daily: [DailyOfferModel]?) {
        
        self.timezone = timeZone
        self.current = current
        self.hourly = hourly
        self.daily = daily
        
    }
    
}
