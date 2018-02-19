//
//  Plant+CoreDataProperties.swift
//  The Drifters
//
//  Created by Graziella Caputo on 19/02/2018.
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
    @NSManaged public var img1: NSData?
    @NSManaged public var scientificName: String?
    @NSManaged public var climate: String?
    @NSManaged public var exposure: String?
    @NSManaged public var dedication: String?
    @NSManaged public var size: String?
    @NSManaged public var category: String?
    @NSManaged public var environment: String?
    @NSManaged public var generalDescription: String?
    @NSManaged public var fertilization: String?
    @NSManaged public var irrigation: String?
    @NSManaged public var pruning: String?
    @NSManaged public var repotting: String?
    @NSManaged public var propagation: String?
    @NSManaged public var illnesses: String?
    @NSManaged public var flowering: String?
    @NSManaged public var origins: String?
    @NSManaged public var pruningDate: NSDate?
    @NSManaged public var repottingDate: NSDate?
    @NSManaged public var list: List?

}
