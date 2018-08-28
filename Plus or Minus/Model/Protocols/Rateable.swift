//
//  Rateable.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 28.08.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation

protocol Rateable {
    var goodProportion: Float { get }
    var badProportion: Float { get }
}
