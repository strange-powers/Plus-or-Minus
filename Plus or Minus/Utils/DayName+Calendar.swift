//
//  DayName+Calendar.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 08.09.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation

extension Calendar {
    
    public enum DayName {
        case Monday
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
        case Saturday
        case Sunday
    }
    
    public func getWeekDayNumber(from name: DayName) -> Int {
        switch name {
        case .Monday:
            return 2
        case .Tuesday:
            return 3
        case .Wednesday:
            return 4
        case .Thursday:
            return 5
        case .Friday:
            return 6
        case .Saturday:
            return 7
        case .Sunday:
            return 1
        }
    }
    
}
