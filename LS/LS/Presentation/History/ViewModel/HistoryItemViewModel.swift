//
//  HistoryItemViewModel.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/26/22.
//

import Foundation

struct HistoryItemViewModel {
    private(set) var foodName: Observable<String?> = Observable(nil)
    private(set) var calories: Observable<String?> = Observable(nil)
    private(set) var progress: Observable<Double> = Observable(0)
    private(set) var fat: Observable<String?> = Observable(nil)

    private let food: FoodProduct

    init(food: FoodProduct) {
        self.food = food

        foodName.value = food.title
        calories.value = "\(food.calories) \(L10n("food.calsPerSaving"))"
        let fatPercent = food.fat / 100.0
        progress.value = fatPercent
        fat.value = "\(food.fat)\(L10n("food.fatPercent"))"
    }

}
