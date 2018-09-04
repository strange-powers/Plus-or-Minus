
//
//  DaysScrollView.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 02.09.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class DaysScrollView: UIScrollView {
    
    var dayButtons = [DayButton]()
    
    public func setup() {
        subviews.forEach({ $0.removeFromSuperview() })
        
        let scrollWidth = frame.size.width
        var itemCount: CGFloat = 0
        
        for button in dayButtons {
            let newX = scrollWidth / 2 + scrollWidth * CGFloat(itemCount)
            
            button.frame.origin.x = newX - (button.frame.width / 2)
            button.frame.origin.y = (frame.size.height / 2) - (button.frame.height / 2)
            addSubview(button)
            
            itemCount = itemCount + 1
        }
        
        clipsToBounds = false
        contentSize = CGSize(width: scrollWidth * itemCount, height: frame.size.height)
    }

}
