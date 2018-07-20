//
//  DayAction+CoreDataProperties.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 05.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//
//

import Foundation
import CoreData


extension DayAction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayAction> {
        return NSFetchRequest<DayAction>(entityName: "DayAction")
    }

    @NSManaged public var conclusion: Bool
    @NSManaged public var day: NSDate?
    @NSManaged public var desc: String?

}
