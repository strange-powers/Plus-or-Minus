//
//  WeekTableViewCell.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 21.08.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class WeekTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.borderWidth = 4
        layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    }
    
    func prepareCellWithData(from week: Week) {
        if week.days.count == 7 {
            let firstDate = DateFormatter.formatDate(week.days.first!.date, with: weekTemplateStr)
            let lastDate = DateFormatter.formatDate(week.days.last!.date, with: weekTemplateStr)
            
            label.text = "\(firstDate) - \(lastDate)"
        } else {
            label.text = "Something went wrong..."
        }
    }

}
