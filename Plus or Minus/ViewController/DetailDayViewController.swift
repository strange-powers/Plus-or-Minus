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
    var day: Day!
    
    /// data for the table view
    private var actions: [[DayAction]]!
    private let actionController = DayActionController()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
        
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
    
    private func reloadData() {
        actionController.loadActionsBy(day: day.date, tell: self)
        day.dayActions = actionController.dayActions
        actions = [day.goodDayActions, day.badDayActions]
    }
    
    /**
     Trigger function when the segment control changes the state
     */
    @IBAction func changeActionConclusion(_ sender: Any?) {
        tableView.reloadData()
    }
    
    /**
     Performs the Segue to a ViewController to add new day actions
    */
    @IBAction func addNewDayAction() {
        performSegue(withIdentifier: "toNewAction", sender: day.date)
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
        reloadData()
        tableView.reloadData()
    }
    
}
