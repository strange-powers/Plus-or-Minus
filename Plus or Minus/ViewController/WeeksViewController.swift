//
//  WeeksViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 03.08.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class WeeksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var weeks = [Week]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let weekDates = Calendar.current.getWeekDates(from: Date())
        let curWeek = Week(days: weekDates)
        curWeek.days.forEach({ $0.loadDayActions() })
        weeks.append(curWeek)
        
        let lastWeeks = getLastWeeksFrom(start: curWeek, counts: 10)
        weeks.append(contentsOf: lastWeeks)
        
        NotificationCenter.default.addObserver(forName: .updateDayActionName, object: nil, queue: nil) { (notification) in
            for index in 0..<self.weeks.count {
                let week = self.weeks[index]
                let indexPath = IndexPath(row: index, section: 1)
                let weekCell = self.tableView.cellForRow(at: indexPath)
                
                weekCell?.setBackgroundColor(by: week)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weekCell") as? WeekTableViewCell {
            let week = weeks[indexPath.row]
            
            cell.prepareCellWithData(from: week)
            cell.setBackgroundColor(by: week)
            
            if week.isEqual(weeks.last!) {
                let nextLastWeeks = getLastWeeksFrom(start: week, counts: 10)
                weeks.append(contentsOf: nextLastWeeks)
                tableView.reloadData()
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentWeekVC = navigationController?.viewControllers[0] as? CurrentWeekViewController {
            currentWeekVC.week = weeks[indexPath.row]
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    /**
     Calculates the last view weeks based on the given input data
     
     - Parameters:
        - week: the week when the calculation should start
        - count: declares how many weeks the function has to calculate
     
     - Returns: the past requested weeks
     */
    private func getLastWeeksFrom(start week: Week, counts count: Int) -> [Week] {
        var lastWeeks = [week]
        
        for index in 0..<count {
            if let firstWeekDay = lastWeeks[index].days.first?.date {
                if let lastDayOfLastWeek = Calendar.current.date(byAdding: .day, value: -1, to: firstWeekDay) {
                    let lastWeek = Calendar.current.getWeekDates(from: lastDayOfLastWeek)
                    let week = Week(days: lastWeek)
                    week.days.forEach({ $0.loadDayActions() })
                    lastWeeks.append(week)
                } else {
                    // TODO: Do some error handling ... but what error handling ?
                }
            } else {
                // TODO: Do some error handling ... but what error handling ?
            }
        }
        
        lastWeeks.remove(at: 0)
        
        return lastWeeks
    }

}
