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
    
    private let _fetchRequest: NSFetchRequest<DayAction> = DayAction.fetchRequest()
    private var _controller: NSFetchedResultsController<DayAction>!
    
    var dayActions: [DayAction] {
        get {
            if let actions = _controller.fetchedObjects {
                return actions
            }
        
            return [DayAction]()
        }
    }
    
    weak var coreDataDelegate: NSFetchedResultsControllerDelegate? {
        get {
            return _controller.delegate
        }
        
        set {
            _controller.delegate = newValue
        }
    }
    
    init() {
        _fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        _controller = NSFetchedResultsController(fetchRequest: _fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    /**
     Fetches all found DayAction objects which have been saved into CoreData which match the NSpredicate. It can be sorted by the given sort descriptors
     
     - Parameters:
        - sortDescriptors: sort descriptors which sort the fetched data (default object is: [NSSortDescriptor(key: "createdAt", ascending: false)])
        - predicate: a predicate to limit the DayAction objects
        - delegate: the delegate object for the NSFetchdResultsController
     */
    private func fetchData(with sortDescriptors: [NSSortDescriptor], and predicate: NSPredicate?) {
        _fetchRequest.predicate = predicate
        _fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            try _controller.performFetch()
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
    func loadActionsBy(day date: Date) {
        let descriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        let predicate = NSPredicate(format: "day = %@", date as NSDate)
        fetchData(with: [descriptor], and: predicate)
    }
    
    /**
     Loads all DayAction objects which lay in the given week
     */
    func loadActionsBy(week dates: [Date]) {
        let descriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        var predicates = [NSPredicate]()
        
        for date in dates {
            let predicate = NSPredicate(format: "day = %@", date as NSDate)
            predicates.append(predicate)
        }
        
        let predicateCompound = NSCompoundPredicate(type: .or, subpredicates: predicates)
        
        fetchData(with: [descriptor], and: predicateCompound)
    }
    
    /**
     Creates a new DayAction object from the given dictionary
     
     - Parameters:
        - data: Contains the data for the new DayAction object. The keys in the dictionary have to be the static string keys of the DayActionController class
     
     - Returns: A new DayAction object
    */
    static func createDayAction(with data: Dictionary<String, Any>) -> DayAction {
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
}
