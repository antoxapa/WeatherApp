//
//  Double + GetWindDirection.swift
//  WeatherApp
//
//  Created by Антон Потапчик on 9/26/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import Foundation

enum Direction: String {
    
    case n
    case nne
    case ne
    case ene
    case e
    case ese
    case se
    case sse
    case s
    case ssw
    case sw
    case wsw
    case w
    case wnw
    case nw
    case nnw
    
}

extension Direction: CustomStringConvertible  {
    
    static let all: [Direction] = [.n, .nne, .ne, .ene, .e, .ese, .se, .sse, .s, .ssw, .sw, .wsw, .w, .wnw, .nw, .nnw]
    
    init(_ direction: Double) {
        
        let index = Int((direction + 11.25).truncatingRemainder(dividingBy: 360) / 22.5)
        self = Direction.all[index]
        
    }
    
    var description: String {
        return rawValue
    }
    
}

extension Double {
    
    var direction: Direction {
        
        return Direction(self)
        
    }
    
}
