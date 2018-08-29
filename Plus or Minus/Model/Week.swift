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
        
        if goodActionsCount == 0 {
            return 0
        }
        
        let allActionsCount = goodActionsCount + Float(badActions.count)
        let proportion = goodActionsCount / allActionsCount
        
        return proportion
    }
    
    var badProportion: Float {
        let badActionsCount = Float(goodActions.count)
        
        if badActionsCount == 0 {
            return 0
        }
        
        let allActionsCount = badActionsCount + Float(goodActions.count)
        let proportion = badActionsCount / allActionsCount
        
        return proportion
    }
    
    init(days: [Day]) {
        self._days = days
    }
    
    init(days: [Date]) {
        self._days = days.map({ Day(date: $0) })
    }
    
}
