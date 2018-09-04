//
//  CurrentWeekViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 03.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit
import CoreData

class CurrentWeekViewController: UIViewController {
    
    @IBOutlet weak var scrollView: DaysScrollView!
    @IBOutlet weak var weekLabel: UILabel!
    
    var week: Week!
    var dayButtons = [DayButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weekDates = Calendar.current.getWeekDates(from: Date())
        week = Week(days: weekDates)
        week.days.forEach({ $0.loadDayActions() })
        
        // Refreshes the UI if a new day action was added in DetailDayViewControrller
        NotificationCenter.default.addObserver(forName: .updateDayActionName, object: nil, queue: nil) { (notification) in
            for index in 0..<self.week.days.count {
                let day = self.week.days[index]
                let dayButton = self.dayButtons[index]
                
                dayButton.setBackgroundColor(by: day)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let firstDate = DateFormatter.formatDate(week.days.first!.date, with: weekTemplateStr)
        let lastDate = DateFormatter.formatDate(week.days.last!.date, with: weekTemplateStr)
        
        weekLabel.text = "\(firstDate) - \(lastDate)"
        
        setUpScrollView()
    }
    
    /**
     Creates and configures a day button with the day given in the arguments
     
     - Parameters:
        - day: The day
     
     - Returns: A configured DayButton object
     */
    private func createDayButton(from day: Day) -> DayButton {
        let circleBtn = DayButton(withDay: day)
        circleBtn.addTarget(self, action: #selector(dateBtnClicked), for: .touchDown)
        
        return circleBtn
    }
    
    /**
     Creates and configures a day button with the name given in the arguments
    */
    private func setUpScrollView() {
        applyDayButtons()

        scrollView.dayButtons = dayButtons
        scrollView.setup()
    }
    
    /**
     Applys created dayButtons to Array
     */
    private func applyDayButtons() {
        for day in week.days {
            let dayBtn = createDayButton(from: day)
            dayBtn.setBackgroundColor(by: day)
            
            dayButtons.append(dayBtn)
        }
    }
    
    @IBAction func dateBtnClicked() {
        let dayIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        performSegue(withIdentifier: "toDayDetail", sender: week.days[dayIndex])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDayDetail" {
            if let detailDayVC = segue.destination as? DetailDayViewController {
                if let day = sender as? Day {
                    detailDayVC.day = day
                }
            }
        }
    }
}

