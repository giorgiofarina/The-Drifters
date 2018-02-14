//
//  Plant+CoreDataProperties.swift
//  The Drifters
//
//  Created by Luis Mautone on 14/02/18.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//
//

import Foundation
import CoreData


extension Plant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plant> {
        return NSFetchRequest<Plant>(entityName: "Plant")
    }

    @NSManaged public var commonName: String?
    @NSManaged public var scientificName: String?
    @NSManaged public var img1: NSData?
    @NSManaged public var list: List?

}
