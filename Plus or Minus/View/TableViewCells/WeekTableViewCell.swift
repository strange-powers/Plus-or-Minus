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
    
    func prepareCellWithData(from week: Week) {
        if week.days.count == 7 {
            let firstDate = formatDate(week.days.first!.date)
            let lastDate = formatDate(week.days.last!.date)
            
            label.text = "\(firstDate) - \(lastDate)"
        } else {
            label.text = "Something went wrong..."
        }
    }
    
    public func setBackgroundColor(by rate: Rateable) {
        let goodRate = CGFloat(rate.goodProportion)
        let badRate = CGFloat(rate.badProportion)
        
        var alphaVal: CGFloat = 1
        if goodRate == 0 && badRate == 0 {
            alphaVal = 0.5
        }
        
        let color = UIColor(red: badRate, green: goodRate, blue: 0, alpha: alphaVal)
        
        backgroundColor = color
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        let dateTemplate = "yMMMMd"
        let format = DateFormatter.dateFormat(fromTemplate: dateTemplate, options: 0, locale: .current)!
        formatter.dateFormat = format
        let formatedDate = formatter.string(from: date)
        
        return formatedDate
    }

}
