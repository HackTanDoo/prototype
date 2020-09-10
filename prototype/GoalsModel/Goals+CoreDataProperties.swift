//
//  Goals+CoreDataProperties.swift
//  prototype
//
//  Created by 김민준 on 2020/09/10.
//  Copyright © 2020 김민준. All rights reserved.
//
//

import Foundation
import CoreData


extension Goals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goals> {
        return NSFetchRequest<Goals>(entityName: "Goals")
    }

    @NSManaged public var day: Date?
    @NSManaged public var clear: Bool
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var aims: ObjectiveGoals?

}
