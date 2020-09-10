//
//  AbstractGoals+CoreDataProperties.swift
//  prototype
//
//  Created by 김민준 on 2020/09/10.
//  Copyright © 2020 김민준. All rights reserved.
//
//

import Foundation
import CoreData


extension AbstractGoals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AbstractGoals> {
        return NSFetchRequest<AbstractGoals>(entityName: "AbstractGoals")
    }

    @NSManaged public var content: String?
    @NSManaged public var title: String?
    @NSManaged public var clear: Bool
    @NSManaged public var objectives: ObjectiveGoals?

}
