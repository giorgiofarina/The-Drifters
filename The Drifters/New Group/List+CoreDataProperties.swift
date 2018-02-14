//
//  List+CoreDataProperties.swift
//  The Drifters
//
//  Created by Luis Mautone on 14/02/18.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var listName: String?
    @NSManaged public var plants: NSSet?

}

// MARK: Generated accessors for plants
extension List {

    @objc(addPlantsObject:)
    @NSManaged public func addToPlants(_ value: Plant)

    @objc(removePlantsObject:)
    @NSManaged public func removeFromPlants(_ value: Plant)

    @objc(addPlants:)
    @NSManaged public func addToPlants(_ values: NSSet)

    @objc(removePlants:)
    @NSManaged public func removeFromPlants(_ values: NSSet)

}
