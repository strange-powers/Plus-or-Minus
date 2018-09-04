//
//  DayButton.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 07.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class DayButton: UIButton {
    /// The buttons font color
    static let TINT_COLOR = UIColor.white
    
    /// The buttons font size
    static let FONT_SIZE: CGFloat = 32.0
    
    /// The buttons width
    static let WIDTH: CGFloat = 200
    
    /// The buttons height
    static let HEIGHT: CGFloat = 200
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
    }
    
    /**
     Initializes the DayButton object with the name of the day and the default sizes
     
     - Parameters
        - name: The name of the day the button represents on view level
     */
    convenience init(withDay day: Day) {
        self.init()
        
        let initials = String(day.dayName.prefix(3))
        setTitle(initials, for: .normal)
    }
    
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: DayButton.WIDTH, height: DayButton.WIDTH)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     Styles the UIButton
    */
    private func setStyle() {
        UIView.makeCircleFrom(self)
        tintColor = DayButton.TINT_COLOR
        layer.borderWidth = 0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: DayButton.FONT_SIZE)
    }

}
