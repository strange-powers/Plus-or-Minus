//
//  WeekDays+Calendar.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 14.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation

extension Calendar {
    /**
     Searches for the days of the week where the given date is in
     
     - Parameters:
        - date: The date of the week
     
     - Return: An array of date objects
    */
    func getWeekDates(from date: Date) -> [Date] {
        let noon = self.date(bySettingHour: 12, minute: 0, second: 0, of: date)!
        var dayOfWeek = component(.weekday, from: noon)
        
        if dayOfWeek == 1 {
            dayOfWeek = 7
        } else {
            dayOfWeek = dayOfWeek - 1
        }
        
        let weekdays = range(of: .weekday, in: .weekOfMonth, for: noon)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { self.date(byAdding: .day, value: $0 - dayOfWeek, to: noon) }
        
        return days
    }
}
