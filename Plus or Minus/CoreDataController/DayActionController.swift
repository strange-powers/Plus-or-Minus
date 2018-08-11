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
    
    private var controller: NSFetchedResultsController<DayAction>?
    
    var dayActions: [DayAction] {
        get {
            if let actions = controller?.fetchedObjects {
                return actions
            }
        
            return [DayAction]()
        }
    }
    
    /**
     Fetches all found DayAction objects which have been saved into CoreData which match the NSpredicate. It can be sorted by the given sort descriptors
     
     - Parameters:
        - sortDescriptors: sort descriptors which sort the fetched data
        - predicate: a predicate to limit the DayAction objects
        - delegate: the delegate object for the NSFetchdResultsController
     */
    private func fetchData(with sortDescriptors: [NSSortDescriptor], and predicate: NSPredicate?, tell delegate: NSFetchedResultsControllerDelegate?) {
        let fetchRequest: NSFetchRequest<DayAction> = DayAction.fetchRequest()
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
    
        controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller!.delegate = delegate
        
        do {
            try controller!.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    /**
     Loads all DayAction objects which day property matches the given date parameter
     
     - Parameters:
        - date: the date object
        - delegate: the delegate object for the NSFetchdResultsController
     */
    func loadActionsBy(day date: Date, tell delegate: NSFetchedResultsControllerDelegate?) {
        let descriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        let predicate = NSPredicate(format: "day = %@", date as NSDate)
        fetchData(with: [descriptor], and: predicate, tell: delegate)
    }
    
    /**
     Loads all DayAction objects which lay in the given week
     */
    func loadActionsBy(week dates: [Date], tell delegate: NSFetchedResultsControllerDelegate?) {
        let descriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        var predicates = [NSPredicate]()
        
        for date in dates {
            let predicate = NSPredicate(format: "day = %@", date as NSDate)
            predicates.append(predicate)
        }
        
        let predicateCompound = NSCompoundPredicate(type: .or, subpredicates: predicates)
        
        fetchData(with: [descriptor], and: predicateCompound, tell: delegate)
    }
    
    /**
     Creates a new DayAction object from the given dictionary
     
     - Parameters:
        - data: Contains the data for the new DayAction object. The keys in the dictionary have to be the static string keys of the DayActionController class
     
     - Returns: A new DayAction object
    */
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
