//
//  Quote+CoreDataProperties.swift
//  prototype
//
//  Created by 김민준 on 2020/09/20.
//  Copyright © 2020 김민준. All rights reserved.
//
//

import Foundation
import CoreData


extension Quote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quote> {
        return NSFetchRequest<Quote>(entityName: "Quote")
    }

    @NSManaged public var artist: String?
    @NSManaged public var content: String?

}

extension Quote : Identifiable {

}
