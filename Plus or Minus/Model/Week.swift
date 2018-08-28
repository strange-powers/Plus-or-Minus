//
//  Week.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 24.08.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation

class Week {
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
    
    init(days: [Day]) {
        self._days = days
    }
    
    init(days: [Date]) {
        self._days = days.map({ Day(date: $0) })
    }
    
}
