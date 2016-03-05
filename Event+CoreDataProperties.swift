//
//  Event+CoreDataProperties.swift
//  RexEvents
//
//  Created by Paul O'Neill on 1/26/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Event {

    @NSManaged var title: String?
    @NSManaged var time: String?
    @NSManaged var date: NSDate?
    @NSManaged var price: NSNumber?
    @NSManaged var eventDescription: String?
    @NSManaged var image: NSData?
    @NSManaged var location: String?
    @NSManaged var id: NSNumber?

}
