//
//  Day.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 09.08.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation
import CoreData
import CoreGraphics

class Day: Rateable {
    private var _date: Date!
    private let _actionController = DayActionController()
    
    weak var dayActionCoreDateDelegate: NSFetchedResultsControllerDelegate? {
        get {
            return _actionController.coreDataDelegate
        }
        
        set {
            _actionController.coreDataDelegate = newValue
        }
    }
    
    
    var dayActions: [DayAction] {
        get {
            return _actionController.dayActions
        }
    }
    
    var goodDayActions: [DayAction] {
        get {
            let actions = dayActions.compactMap { (action) -> DayAction? in
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
            let actions = dayActions.compactMap { (action) -> DayAction? in
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
    
    var goodProportion: Float {
        let allActionsCount = Float(dayActions.count)
        let goodDayActionsCount = Float(goodDayActions.count)
        
        return Float.calculateProportions(with: allActionsCount, dividedBy: goodDayActionsCount)
    }
    
    var badProportion: Float {
        let allActionsCount = Float(dayActions.count)
        let badDayActionsCount = Float(badDayActions.count)
        
        return Float.calculateProportions(with: allActionsCount, dividedBy: badDayActionsCount)
    }
    
    init(date: Date) {
        _date = date
    }
    
    public func loadDayActions() {
        _actionController.coreDataDelegate = dayActionCoreDateDelegate
        _actionController.loadActionsBy(day: _date)
    }
}
