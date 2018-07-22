//
//  DayActionDataSource.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 20.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation
import UIKit

class DayActionDataSource: NSObject, UITableViewDataSource {
    
    /// the conclusion of the DayAction objects
    var currentLoadedConclusion: Bool!
    
    /// the saved DayAction objects
    private var _actions = [DayAction]()
    
    /// Getter for _actions
    var actions: [DayAction] {
        return  _actions
    }
    
    init(with conclusion: Bool) {
        currentLoadedConclusion = conclusion
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DayActionCell") as? DayActionTableViewCell {
            let action = _actions[indexPath.row]
            
            cell.prepareCellWithData(from: action)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    /**
     Loads the DayActions from CoreData
     */
    func loadActions() {
        let predicate = NSPredicate(format: "conclusion = %d", currentLoadedConclusion)
        let descriptor = NSSortDescriptor(key: "conclusion", ascending: currentLoadedConclusion)
        let actionController = DayActionController()
        
        _actions = actionController.fetchData(with: [descriptor], and: predicate)
    }
}
