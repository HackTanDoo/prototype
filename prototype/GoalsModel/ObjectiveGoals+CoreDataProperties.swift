//
//  ObjectiveGoals+CoreDataProperties.swift
//  prototype
//
//  Created by 김민준 on 2020/09/10.
//  Copyright © 2020 김민준. All rights reserved.
//
//

import Foundation
import CoreData


extension ObjectiveGoals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ObjectiveGoals> {
        return NSFetchRequest<ObjectiveGoals>(entityName: "ObjectiveGoals")
    }

    @NSManaged public var content: String?
    @NSManaged public var title: String?
    @NSManaged public var clear: Bool
    @NSManaged public var tags: AbstractGoals?
    @NSManaged public var goals: Goals?

}
