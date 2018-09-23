//
//  WeekDayDayAction.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 07.09.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation

class WeekDayDayAction: Rateable {
    
    private var _dayName: Calendar.DayName!
    private var _goodProportion: Float = 0
    private var _badProportion: Float = 0
    
    init(dayName: Calendar.DayName) {
        _dayName = dayName
    }
    
    var goodProportion: Float {
        return _goodProportion
    }
    
    var badProportion: Float {
        return _badProportion
    }
    
    /**
     Calculates the Proportions of the good and bad day actions which where added between two dates
     
     - Parameters:
         - date1: start point
         - date2: end point
     */
    public func calculateProportions(between date1: Date, and date2: Date) {
            let dayActions = gatherDayAction(of: _dayName, from: date1, to: date2)
            setProportions(for: dayActions)
    }
    
    /**
     Calculates the Proportions of the good and bad day actions which where added in the given year
     
     - Parameters:
        - year: the year in which the day actions reference to
     */
    public func calculateProportions(for year: Int) {
        let currentCalendar = Calendar.current
        let askedYearcomponent = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, era: nil, year: year, month: 1, day: 1, hour: 12)
        let nextYearcomponent = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, era: nil, year: year + 1, month: 1, day: 1, hour: 12)
        
        if let firstDay = currentCalendar.date(from: askedYearcomponent) {
            if let firstDayOfNextYear = currentCalendar.date(from: nextYearcomponent) {
                if let lastDay = currentCalendar.date(byAdding: .day, value: -1, to: firstDayOfNextYear) {
                    let dayActions = gatherDayAction(of: _dayName, from: firstDay, to: lastDay)
                    setProportions(for: dayActions)
                }
            }
        }
    }
    
    /**
     Sets the proportions for the given day actions
     
     - Parameters:
        - dayActions: the day actions on which the calculation is based
    */
    private func setProportions(for dayActions: [DayAction]) {
        let goodDayActions = dayActions.compactMap { (action) -> DayAction? in
            if action.conclusion {
                return action
            }
    
            return nil
        }
        
        let badDayActions = dayActions.compactMap { (action) -> DayAction? in
            if !action.conclusion {
                return action
            }
            
            return nil
        }
        
        let dayActionsCount = Float(dayActions.count)
        _goodProportion = Float.calculateProportions(with: dayActionsCount, dividedBy: Float(goodDayActions.count))
        _badProportion = Float.calculateProportions(with: dayActionsCount, dividedBy: Float(badDayActions.count))
    }
    
    /**
     Gathers day actions based on the dayname and a time ranche
     
     - Parameters:
         - day: the day name
         - date1: start date
         - date2: end date
     
     - Returns: the found day actions as an Array
     */
    private func gatherDayAction(of day: Calendar.DayName, from date1: Date, to date2: Date) -> [DayAction] {
        var actions = [DayAction]()
        
        let days = Calendar.current.getWeekDays(between: date1, and: date2, ofType: day, in: TimeZone.current)
        let dayActionContoller = DayActionController()
        dayActionContoller.loadActionsBy(week: days)
        actions = dayActionContoller.dayActions
        
        return actions
    }
    
}
