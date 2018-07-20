//
//  ViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 03.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    /*
     TODO: there will be a caching problem if the user does not shut down the app after every week
     */
    /// Stores the days of the current week in an Date array
    lazy var weekDays: [Date] = {
        return Calendar.current.getWeekDates(from: Date())
    }()
    
    /// Generates the days name of the weekDays array
    var dayNames: [String] {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            
            let dayNames = weekDays.compactMap {
                formatter.string(from: $0)
            }
            
            return dayNames
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScrollView()
    }
    
    /**
     Creates and configures a day button with the name given in the arguments
     
     - Parameters:
        - name: The name of the day
     
     - Returns: A configured DayButton object
     */
    private func createDayButton(with name: String) -> DayButton {
        let dayInitials = String(name.prefix(3))
        let circleBtn = DayButton(withDayName: dayInitials)
        circleBtn.addTarget(self, action: #selector(dateBtnClicked), for: .touchDown)
        
        return circleBtn
    }
    
    
    /**
     Creates and configures a day button with the name given in the arguments
    */
    private func setUpScrollView() {
        let scrollWidth = scrollView.frame.size.width
        var itemCount: CGFloat = 0
        
        for dayName in dayNames {
            let newX = scrollWidth / 2 + scrollWidth * CGFloat(itemCount)
            
            let dayBtn = createDayButton(with: dayName)
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
        performSegue(withIdentifier: "toDayDetail", sender: weekDays[dayIndex])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDayDetail" {
            if let detailDayVC = segue.destination as? DetailDayViewController {
                if let day = sender as? Date {
                    detailDayVC.day = day
                }
            }
        }
    }
}

