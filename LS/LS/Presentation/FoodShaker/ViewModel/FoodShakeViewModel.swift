//
//  FoodShakeViewModel.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import UIKit

final class FoodShakeViewModel {

    let tip = L10n("tip.shake")
    var tipStatus: Observable<TipStatus?> = Observable(nil)
    enum TipStatus {
        case animating
        case hidden
    }

    var error: Observable<String?> = Observable(nil)

    var isDataLoaded: Observable<Bool> = Observable(false)

    let caloriesSubtitle = L10n("food.caloriesPerSaving")

    let carbsTitle = L10n("food.carbs").uppercased()
    let proteinTitle = L10n("food.protein").uppercased()
    let fatTitle = L10n("food.fat").uppercased()

    var foodName: Observable<String?> = Observable(nil)

    var calories: Observable<String?> = Observable(nil)
    var carbs: Observable<String?> = Observable(nil)
    var protein: Observable<String?> = Observable(nil)
    var fat: Observable<String?> = Observable(nil)

    var colors: Observable<[UIColor]?> = Observable(nil)

    private var food: FoodProduct? {
        didSet {
            triggerUpdate()
        }
    }

    private var loadingTask: Cancellable? {
        willSet {
            loadingTask?.cancel()
        }
    }

    private let useCase: FoodShakeUseCase

    init(useCase: FoodShakeUseCase) {
        self.useCase = useCase
    }
}

// MARK: - Actions

extension FoodShakeViewModel {

    func viewDidAppear() {
        tipStatus.value = food == nil ? .animating : .hidden
    }

    func didShakeDevice() {
        loadingTask = useCase.getRandomProduct { [weak self] result in
            guard let self = self else { return }

            defer {
                self.loadingTask = nil
            }
            // TODO: handle result

            switch result {
            case .success(let food):
                self.food = food

            case .failure(let error):
                self.handle(error: error)
            }
        }
    }
}

// MARK: - Private

private extension FoodShakeViewModel {
    func handle(error: Error) {
        self.error.value = error.localizedDescription
    }

    func triggerUpdate() {
        defer {
            isDataLoaded.value = food != nil
        }

        guard let food = food else { return }

        foodName.value = food.title

        calories.value = food.calories.stringValue
        carbs.value = food.carbs.stringValue
        protein.value = food.protein.stringValue
        fat.value = food.fat.stringValue

        colors.value = getRandomGradient()
    }

    func getRandomGradient() -> [UIColor] {
        let id = Int.random(in: 0..<AppTheme.Gradient.allCases.count)
        return AppTheme.Gradient.allCases[id].colors
    }
}

// MARK: - Double to string

extension Double {
    var stringValue: String? {
        String(self)
    }
}
