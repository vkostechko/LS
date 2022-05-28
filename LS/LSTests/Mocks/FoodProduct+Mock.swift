//
//  FoodProduct+Mock.swift
//  LSTests
//
//  Created by Viachaslau Kastsechka on 5/28/22.
//

import Foundation

extension FoodProduct {

    static func stub() -> FoodProduct {
        FoodProduct(title: "Ricotta cheese",
                    pcsText: "Whole cheese",
                    carbs: 3.04,
                    fiber: 0.0,
                    potassium: 0.105,
                    sodium: 0.084,
                    calories: 174,
                    fat: 12.98,
                    sugar: 0.27,
                    gramsPerServing: 20.0,
                    cholesterol: 0.051,
                    protein: 11.26,
                    unsaturatedFat: 4.012,
                    saturatedFat: 8.295)
    }
}
