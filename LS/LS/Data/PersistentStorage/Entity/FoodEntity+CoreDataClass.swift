//
//  FoodEntity+CoreDataClass.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/24/22.
//
//

import Foundation
import CoreData

@objc(FoodEntity)
public class FoodEntity: NSManagedObject {

}

// MARK: - Domain

extension FoodEntity {
    func toDTO() -> FoodProductDTO {
        FoodProductDTO(title: title,
                       pcsText: pcsText,
                       carbs: carbs,
                       fiber: fiber,
                       potassium: potassium,
                       sodium: sodium,
                       calories: calories,
                       fat: fat,
                       sugar: sugar,
                       gramsPerServing: gramsPerServing,
                       cholesterol: cholesterol,
                       protein: protein,
                       unsaturatedFat: unsaturatedFat,
                       saturatedFat: saturatedFat)
    }

}

extension FoodProductDTO {

    func toEntity(in context: NSManagedObjectContext) -> FoodEntity {
        let entity = FoodEntity(context: context)

        entity.title = title
        entity.pcsText = pcsText
        entity.carbs = carbs
        entity.fiber = fiber
        entity.potassium = potassium
        entity.sodium = sodium
        entity.calories = calories
        entity.fat = fat
        entity.sugar = sugar
        entity.gramsPerServing = gramsPerServing
        entity.cholesterol = cholesterol
        entity.protein = protein
        entity.unsaturatedFat = unsaturatedFat
        entity.saturatedFat = saturatedFat

        return entity
    }
}
