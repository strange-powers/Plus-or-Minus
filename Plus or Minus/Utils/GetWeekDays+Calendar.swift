//
//  GetWeekDays+Calendar.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 08.09.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation

extension Calendar {
    
    public func getWeekDays(between date1: Date, and date2: Date, ofType day: DayName, in zone: TimeZone) -> [Date] {
        var dates = [Date]()
        var weekComponent = DateComponents()
        weekComponent.calendar = self
        weekComponent.timeZone = zone
        weekComponent.hour = 12
        weekComponent.weekday = getWeekDayNumber(from: day)
        
        enumerateDates(startingAfter: date1, matching: weekComponent, matchingPolicy: .previousTimePreservingSmallerComponents, repeatedTimePolicy: .first, direction: .backward) { (day, match, stop) in
            if let date = day {
                if date < date2 {
                    stop = true
                } else {
                    dates.append(date)
                }
            }
        }
        
        return dates
    }
    
}
