//
//  CalculateProportions+Float.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 21.09.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation

extension Float {
    static func calculateProportions(with baseValue: Float, dividedBy value: Float) -> Float {
        if baseValue == 0 {
            return 0
        }
        
        let proportion = value / baseValue
        
        return proportion
    }
}
