//
//  HistoryEntity+CoreDataProperties.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/25/22.
//
//

import Foundation
import CoreData


extension HistoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryEntity> {
        return NSFetchRequest<HistoryEntity>(entityName: "HistoryEntity")
    }

    @NSManaged public var shakeDate: Date?
    @NSManaged public var foodEntity: FoodEntity?

}

extension HistoryEntity : Identifiable {

}
