//
//  HistoryItemViewModel.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/26/22.
//

import UIKit

struct HistoryItemViewModel {
    private(set) var foodName: Observable<String?> = Observable(nil)
    private(set) var calories: Observable<String?> = Observable(nil)
    private(set) var saturatedFatRate: Observable<Double> = Observable(0)
    private(set) var unsaturatedFatPercent: Observable<String?> = Observable(nil)
    private(set) var colors: Observable<[UIColor]?> = Observable(nil)

    private let food: FoodProduct

    init(food: FoodProduct) {
        self.food = food

        foodName.value = food.title
        calories.value = "\(food.calories) \(L10n("food.calsPerSaving"))"
        saturatedFatRate.value = food.saturatedFat
        unsaturatedFatPercent.value = "\(food.unsaturatedFat)\(L10n("food.unsaturatedFatPercent"))"

        colors.value = AppTheme.getRandomGradient()
    }

}
