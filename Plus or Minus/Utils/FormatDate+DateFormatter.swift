//
//  FormatDate+DateFormatter.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 29.08.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func formatDate(_ date: Date, with template: String) -> String {
        let formatter = DateFormatter()
        let dateTemplate = template
        let format = DateFormatter.dateFormat(fromTemplate: dateTemplate, options: 0, locale: .current)!
        formatter.dateFormat = format
        let formatedDate = formatter.string(from: date)
        
        return formatedDate
    }
}
