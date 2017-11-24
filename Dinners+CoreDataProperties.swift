//
//  Dinners+CoreDataProperties.swift
//  DinnerWithFriends2
//
//  Created by Bart Bronselaer on 23/11/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//
//

import Foundation
import CoreData


extension Dinners {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dinners> {
        return NSFetchRequest<Dinners>(entityName: "Dinners")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var dinnerdescription: String?
    @NSManaged public var rating: Int16
    @NSManaged public var url: URL?
    @NSManaged public var notes: String?
    @NSManaged public var picture: NSData?
    @NSManaged public var friends: NSObject?

}
