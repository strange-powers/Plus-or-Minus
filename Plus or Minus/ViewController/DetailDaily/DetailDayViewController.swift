//
//  DetailDayPageViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 20.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class DetailDayViewController: UIViewController, UITableViewDelegate {
    
    
    /// day of which actions shall be shown up
    var day: Date!
    
    /// data sources for the table view
    var dataSources = [DayActionDataSource]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDataSources()
        
        tableView.delegate = self
        tableView.dataSource = dataSources[0]
    }
    
    /**
     Trigger function when the segment control changes the state
     */
    @IBAction func changeActionConclusion(_ sender: Any?) {
        let segmentIndex = segmentControl.selectedSegmentIndex
        
        tableView.dataSource = dataSources[segmentIndex]
        tableView.reloadData()
    }
    
    /**
     Creates and loads the datasource objects with the model
     */
    private func setUpDataSources() {
        let goodActionDataSource = DayActionDataSource(with: true)
        let badActionDataSource = DayActionDataSource(with: false)
        
        goodActionDataSource.loadActions()
        badActionDataSource.loadActions()
        
        dataSources.append(goodActionDataSource)
        dataSources.append(badActionDataSource)
    }
    
}
