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
    
    /**
     Returns all found DayAction objects which have been saved into CoreData which match the NSpredicate. It can be sorted by the given sort descriptors
     
     - Parameters:
        - sortDescriptors: sort descriptors which sort the fetched data
        - predicate: a predicate to limit the DayAction objectss
     
     - Returns: The found DayAction objects in an Array
     */
    func fetchData(with sortDescriptors: [NSSortDescriptor], and predicate: NSPredicate) -> [DayAction] {
        let fetchRequest: NSFetchRequest<DayAction> = DayAction.fetchRequest()
        var actions = [DayAction]()
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
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
    
}
