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
    
    @IBOutlet weak var scrollView: UIScrollView!
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
        dayButtons.removeAll()
        scrollView.subviews.forEach({ $0.removeFromSuperview() })
        
        let scrollWidth = scrollView.frame.size.width
        var itemCount: CGFloat = 0
        
        for day in week.days {
            let newX = scrollWidth / 2 + scrollWidth * CGFloat(itemCount)
        
            let dayBtn = createDayButton(from: day)
            dayBtn.setBackgroundColor(by: day)
            dayBtn.frame.origin.x = newX - (dayBtn.frame.width / 2)
            dayBtn.frame.origin.y = (scrollView.frame.size.height / 2) - (dayBtn.frame.height / 2)
            scrollView.addSubview(dayBtn)
            dayButtons.append(dayBtn)
            
            itemCount = itemCount + 1
        }
        
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: scrollWidth * itemCount, height: scrollView.frame.size.height)
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

