//
//  CurrentWeekViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 03.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class CurrentWeekViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var week: Week!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weekDates = Calendar.current.getWeekDates(from: Date())
        week = Week(days: weekDates)
        week.days.forEach({ $0.loadDayActions() })
        
        setUpScrollView()
    }
    
    /**
     Creates and configures a day button with the name given in the arguments
     
     - Parameters:
        - name: The name of the day
     
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
        let scrollWidth = scrollView.frame.size.width
        var itemCount: CGFloat = 0
        
        for day in week.days {
            let newX = scrollWidth / 2 + scrollWidth * CGFloat(itemCount)
            
            let dayBtn = createDayButton(from: day)
            dayBtn.setBackgroundColor(by: day)
            dayBtn.frame.origin.x = newX - (dayBtn.frame.width / 2)
            dayBtn.frame.origin.y = (scrollView.frame.size.height / 2) - (dayBtn.frame.height / 2)
            scrollView.addSubview(dayBtn)
            
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

