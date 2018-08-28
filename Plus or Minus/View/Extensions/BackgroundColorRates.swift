//
//  BackgroundColorRates.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 28.08.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

protocol BackgroundColorRates {
    func setBackgroundColor(by rate: Rateable)
}

extension BackgroundColorRates where Self: UIView {
    
    /**
     Sets the colour of the button depending on the given Ratings
     
     - Parameters
     - rate: Rateable protocol which serves the data to calculate the color
     */
    func setBackgroundColor(by rate: Rateable) {
        let goodRate = CGFloat(rate.goodProportion)
        let badRate = CGFloat(rate.badProportion)
        
        var alphaVal: CGFloat = 1
        if goodRate == 0 && badRate == 0 {
            alphaVal = 0.5
        }
        
        let color = UIColor(red: badRate, green: goodRate, blue: 0, alpha: alphaVal)
        
        backgroundColor = color
    }
    
}

extension UIButton: BackgroundColorRates {}
extension UITableViewCell: BackgroundColorRates {}
