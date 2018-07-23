//
//  DetailDayPageViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 20.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class DetailDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    /// day of which actions shall be shown up
    var day: Date!
    
    /// data for the table view
    private var actions = [[DayAction]]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpActions()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions[segmentControl.selectedSegmentIndex].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DayActionCell") as? DayActionTableViewCell {
            let action = actions[segmentControl.selectedSegmentIndex][indexPath.row]
            
            cell.prepareCellWithData(from: action)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    /**
     Trigger function when the segment control changes the state
     */
    @IBAction func changeActionConclusion(_ sender: Any?) {
        tableView.reloadData()
    }
    
    /**
     Creates and loads the datasource objects with the model
     */
    private func setUpActions() {
        let loadedActions = loadActions()
        
        let goodActions = loadedActions.compactMap { (dayAction) -> DayAction? in
            if dayAction.conclusion {
                return dayAction
            }
            
            return nil
        }
        actions.append(goodActions)
        
        let badActions = loadedActions.compactMap { (dayAction) -> DayAction? in
            if !dayAction.conclusion {
                return dayAction
            }
            
            return nil
        }
        actions.append(badActions)
        
    }
    
    /**
     Loads the DayActions from CoreData
     */
    func loadActions() -> [DayAction] {
        let descriptor = NSSortDescriptor(key: "day", ascending: true)
        let actionController = DayActionController()
        
        let actions = actionController.fetchData(with: [descriptor], and: nil)
        
        return actions
    }
    
}
