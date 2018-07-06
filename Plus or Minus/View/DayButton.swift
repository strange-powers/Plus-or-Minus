//
//  DayButton.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 07.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class DayButton: UIButton {
    private let TINT_COLOR = UIColor.white
    private let BACKGROUND_COLOR = UIColor.green
    private let FONT_SIZE:CGFloat = 32.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        styleButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func styleButton() {
        UIView.makeCircleFrom(self)
        backgroundColor = BACKGROUND_COLOR
        tintColor = TINT_COLOR
        layer.borderWidth = 0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: FONT_SIZE)
    }

}
