//
//  ViewExtension.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 06.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

extension UIView {
    func makeCircle() {
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
        layer.borderColor = layer.borderColor
        layer.borderWidth = 0.5
    }
}
