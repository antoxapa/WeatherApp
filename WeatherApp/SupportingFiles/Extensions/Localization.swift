//
//  Localization.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/28/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var localized: String {
        
        return NSLocalizedString(self, comment: "")
        
    }
    
    func localized(with values: CVarArg...) -> String {
        
        return String.init(format: NSLocalizedString(self, comment: ""), arguments: values)
        
    }
    
}
