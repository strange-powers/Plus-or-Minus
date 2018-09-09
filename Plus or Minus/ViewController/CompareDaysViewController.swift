//
//  CompareDaysViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 03.09.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class CompareDaysViewController: UIViewController {
    
    @IBOutlet weak var scrollView: DaysScrollView!
    
    private var _goodProportion: Float = 0
    private var _badProportion: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.dayButtons = createDayButtons()
        scrollView.setup()
    }
    
    private func createDayButtons() -> [DayButton] {
        var dayButtons = [DayButton]()
        
        if let todayLastYear = Calendar.current.date(byAdding: .day, value: -365, to: Date()) {
            let dayNamesStr = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
            let dayNamesEn = [
                Calendar.DayName.Monday,
                Calendar.DayName.Tuesday,
                Calendar.DayName.Wednesday,
                Calendar.DayName.Thursday,
                Calendar.DayName.Friday,
                Calendar.DayName.Saturday,
                Calendar.DayName.Sunday
            ]
            
            for index in 0..<dayNamesStr.count {
                let weekDayDayActionController = WeekDayDayAction(dayName: dayNamesEn[index])
                let dayButton = DayButton()
                
                weekDayDayActionController.calculateProportions(between: Date(), and: todayLastYear)
                dayButton.setBackgroundColor(by: weekDayDayActionController)
                dayButton.setTitleWithInitials(title: dayNamesStr[index])
                
                dayButtons.append(dayButton)
            }
            
        }
        
        return dayButtons
    }
    
}
