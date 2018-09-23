//
//  Week.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 24.08.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation

class Week: NSObject, Rateable {
    
    private var _days: [Day]!
    
    var days: [Day] {
        return _days
    }
    
    var badActions: [DayAction] {
        var actions = [DayAction]()
        
        for day in days {
            actions.append(contentsOf: day.badDayActions)
        }
        
        return actions
    }
    
    var goodActions: [DayAction] {
        var actions = [DayAction]()
        
        for day in days {
            actions.append(contentsOf: day.goodDayActions)
        }
        
        return actions
    }
    
    var goodProportion: Float {
        let goodActionsCount = Float(goodActions.count)
        let allActionsCount = goodActionsCount + Float(badActions.count)
        
        return Float.calculateProportions(with: allActionsCount, dividedBy: goodActionsCount)
    }
    
    var badProportion: Float {
        let badActionsCount = Float(badActions.count)
        let allActionsCount = badActionsCount + Float(goodActions.count)
        
        return Float.calculateProportions(with: allActionsCount, dividedBy: badActionsCount)
    }
    
    init(days: [Day]) {
        self._days = days
    }
    
    init(days: [Date]) {
        self._days = days.map({ Day(date: $0) })
    }
    
}
