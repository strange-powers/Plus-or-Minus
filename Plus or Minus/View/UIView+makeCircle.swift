//
//  ViewExtension.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 06.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

extension UIView {
    static func makeCircleFrom(_ view: UIView) {
        view.layer.cornerRadius = view.frame.size.width / 2
        view.clipsToBounds = true
        view.layer.borderColor = view.layer.borderColor
        view.layer.borderWidth = 0.5
    }
}
