//
//  DetailDayPageViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 20.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit
import CoreData

class DetailDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    /// day of which actions shall be shown up
    var day: Date!
    
    /// data for the table view
    private var actions = [[DayAction]]()
    private let actionController = DayActionController()
    
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
        actions.removeAll()
        loadActions()
        let dayActions = actionController.dayActions
        
        let goodActions = dayActions.compactMap { (dayAction) -> DayAction? in
            if dayAction.conclusion {
                return dayAction
            }
            
            return nil
        }
        actions.append(goodActions)
        
        let badActions = dayActions.compactMap { (dayAction) -> DayAction? in
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
    private func loadActions() {
        let descriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        let predicate = NSPredicate(format: "day = %@", day as NSDate)
        actionController.fetchData(with: [descriptor], and: predicate, tell: self)
    }
    
    /**
     Performs the Segue to a ViewController to add new day actions
    */
    @IBAction func addNewDayAction() {
        performSegue(withIdentifier: "toNewAction", sender: day)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewAction" {
            if let newActionVC = segue.destination as? NewActionViewController {
                if let day = sender as? Date {
                    newActionVC.day = day
                }
            }
        }
    }
    
    /**
     Reloads the table if there was a change in the database
    */
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        setUpActions()
        
        tableView.reloadData()
    }
    
}
