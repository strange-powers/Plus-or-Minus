//
//  WeeksViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 03.08.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class WeeksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var weeks = [[Day]]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let weekDates = Calendar.current.getWeekDates(from: Date())
        let curWeek = weekDates.map({ Day(date: $0) })
        weeks.append(curWeek)
        
        for index in 0..<10 {
            if let firstWeekDay = weeks[index].first?.date {
                if let lastDayOfLastWeek = Calendar.current.date(byAdding: .day, value: -1, to: firstWeekDay) {
                    let lastWeek = Calendar.current.getWeekDates(from: lastDayOfLastWeek)
                    let week = lastWeek.map({ Day(date: $0) })
                    weeks.append(week)
                } else {
                    // TODO: Do some error handling ... but what error handling ?
                }
            } else {
                // TODO: Do some error handling ... but what error handling ?
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
            cell.prepareCellWithData(from: weeks[indexPath.row])
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

}
