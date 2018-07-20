//
//  DetailDayPageViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 20.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class DetailDayViewController: UIViewController, UITableViewDelegate {
    
    var day: Date!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
    }
    
    
}
