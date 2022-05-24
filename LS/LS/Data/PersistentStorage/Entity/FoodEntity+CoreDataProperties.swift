//
//  FoodEntity+CoreDataProperties.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/24/22.
//
//

import Foundation
import CoreData


extension FoodEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodEntity> {
        return NSFetchRequest<FoodEntity>(entityName: "FoodEntity")
    }

    @NSManaged public var calories: Double
    @NSManaged public var carbs: Double
    @NSManaged public var cholesterol: Double
    @NSManaged public var fat: Double
    @NSManaged public var fiber: Double
    @NSManaged public var foodId: Int
    @NSManaged public var gramsPerServing: Double
    @NSManaged public var pcsText: String
    @NSManaged public var potassium: Double
    @NSManaged public var protein: Double
    @NSManaged public var saturatedFat: Double
    @NSManaged public var sodium: Double
    @NSManaged public var sugar: Double
    @NSManaged public var title: String
    @NSManaged public var unsaturatedFat: Double

}

extension FoodEntity : Identifiable {

}
