//
//  CompareDaysViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 03.09.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class CompareDaysViewController: UIViewController, Rateable {
    
    @IBOutlet weak var scrollView: DaysScrollView!
    
    var goodProportion: Float {
        return 1
    }
    
    var badProportion: Float {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.dayButtons = createDayButtons()
        scrollView.setup()
    }
    
    private func createDayButtons() -> [DayButton] {
        let dayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        var dayButtons = [DayButton]()
        
        for name in dayNames {
            let dayButton = DayButton()
            dayButton.setTitle(name, for: .normal)
            dayButton.setBackgroundColor(by: self)
            
            dayButtons.append(dayButton)
        }
        
        return dayButtons
    }
    
}
