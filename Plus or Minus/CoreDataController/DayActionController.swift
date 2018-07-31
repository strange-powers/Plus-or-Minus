//
//  DayActionController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 20.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation
import CoreData

class DayActionController {
    
    /// TODO: Try key value pairs instead
    static let CONCLUSION_KEY = "conclusion"
    static let DAY_KEY = "day"
    static let DESC_KEY = "desc"
    static let CREATED_AT_KEY = "createdAt"
    
    var controller: NSFetchedResultsController<DayAction>!
    
    /**
     Returns all found DayAction objects which have been saved into CoreData which match the NSpredicate. It can be sorted by the given sort descriptors
     
     - Parameters:
        - sortDescriptors: sort descriptors which sort the fetched data
        - predicate: a predicate to limit the DayAction objectss
     
     - Returns: The found DayAction objects in an Array
     */
    func fetchData(with sortDescriptors: [NSSortDescriptor], and predicate: NSPredicate?) -> [DayAction] {
        let fetchRequest: NSFetchRequest<DayAction> = DayAction.fetchRequest()
        var actions = [DayAction]()
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try controller.performFetch()
            if let acts = controller.fetchedObjects {
                actions = acts
            }
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
        return actions
    }
    
    func createDayAction(with data: Dictionary<String, Any>) -> DayAction {
        let action = DayAction(context: context)
        
        if let conclusion = data[DayActionController.CONCLUSION_KEY] as? Bool {
            action.conclusion = conclusion
        }
        
        if let desc = data[DayActionController.DESC_KEY] as? String {
            action.desc = desc
        }
        
        if let day = data[DayActionController.DAY_KEY] as? NSDate {
            action.day = day
        }
        
        if let createdAt = data[DayActionController.CREATED_AT_KEY] as? NSDate {
            action.createdAt = createdAt
        }
        
        return action
    }
    
    func saveDayActions() {
        application.saveContext()
    }
}
