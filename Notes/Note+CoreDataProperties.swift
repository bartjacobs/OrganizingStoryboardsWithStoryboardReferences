//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Bart Jacobs on 19/07/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Note {

    @NSManaged var content: String?
    @NSManaged var createdAt: NSTimeInterval
    @NSManaged var title: String?
    @NSManaged var updatedAt: NSTimeInterval

}
