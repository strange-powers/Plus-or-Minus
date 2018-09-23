//
//  DayAction+CoreDataClass.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 31.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//
//

import Foundation
import CoreData


public class DayAction: NSManagedObject {
    /**
     Calculates good day actions from a given day action Array.
     
     - Parameters:
        - dayActions: calculation base
     
     - Returns: The good day actions
     */
    static func getGoodDayActions(from dayActions: [DayAction]) -> [DayAction] {
        return DayAction.getDayActions(from: dayActions, with: true)
    }
    
    /**
     Calculates bad day actions from a given day action Array.
     
     - Parameters:
        - dayActions: calculation base
     
     - Returns: The bad day actions
     */
    static func getBadDayActions(from dayActions: [DayAction]) -> [DayAction] {
        return DayAction.getDayActions(from: dayActions, with: false)
    }
    
    /**
     Calculates day actions from a given day action Array with the desired day action conclusion.
     
     - Parameters:
        - dayActions: calculation base
        - conclusion: the desired conclusion
     
     - Returns: The calculated day actions
     */
    private static func getDayActions(from dayActions: [DayAction], with conclusion: Bool) -> [DayAction]  {
        let actions = dayActions.compactMap { (action) -> DayAction? in
            if action.conclusion == conclusion {
                return action
            }
            
            return nil
        }
        
        return actions
    }
}
