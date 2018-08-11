//
//  Day.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 09.08.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation

class Day {
    private var _dayActions = [DayAction]()
    private var _date: Date!
    
    var dayActions: [DayAction] {
        get {
            return _dayActions
        }
        
        set {
            _dayActions = newValue
        }
    }
    
    var goodDayActions: [DayAction] {
        get {
            let actions = _dayActions.compactMap { (action) -> DayAction? in
                if action.conclusion {
                    return action
                }
                
                return nil
            }
        
            return actions
            
        }
    }
    
    var badDayActions: [DayAction] {
        get {
            let actions = _dayActions.compactMap { (action) -> DayAction? in
                if !action.conclusion {
                    return action
                }
                
                return nil
            }
            
            return actions
            
        }
    }
    
    var date: Date {
        return _date
    }
    
    var dayName: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
        
            return formatter.string(from: date)
        }
    }
    
    init(date: Date) {
        _date = date
    }
}
