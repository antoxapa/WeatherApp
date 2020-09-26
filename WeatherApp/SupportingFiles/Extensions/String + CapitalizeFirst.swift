//
//  String + CapitalizeFirst.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/25/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

extension StringProtocol {
    
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
    
}


