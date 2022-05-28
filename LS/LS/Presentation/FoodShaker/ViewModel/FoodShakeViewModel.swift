//
//  FoodShakeViewModel.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import UIKit

struct FoodShakeViewModelActions {
    let showDetails: (FoodProduct) -> Void
    let showHistory: () -> Void
}

final public class FoodShakeViewModel {

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

    let moreButtonTitle = L10n("button.moreInfo")

    var hasHistory: Observable<Bool?> = Observable(nil)

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
    private let actions: FoodShakeViewModelActions?

    init(useCase: FoodShakeUseCase, actions: FoodShakeViewModelActions?) {
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Actions

public extension FoodShakeViewModel {

    func viewDidAppear() {
        tipStatus.value = food == nil ? .animating : .hidden
    }

    func didShakeDevice() {
        loadingTask = useCase.getRandomProduct(cached: { [weak self] food in
            self?.food = food

        }, completion: { [weak self] result in
            guard let self = self else { return }

            defer {
                self.loadingTask = nil
            }

            switch result {
            case .success(let food):
                if self.food != food {
                    self.food = food
                }

            case .failure(let error):
                self.handle(error: error)
            }
        })
    }

    func didTapDetailsButton() {
        if let food = food {
            actions?.showDetails(food)
        }
    }

    func didTapHistoryButton() {
        actions?.showHistory()
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
            hasHistory.value = food != nil
        }

        guard let food = food else { return }

        foodName.value = food.title

        calories.value = food.calories.formattedValue
        carbs.value = food.carbs.formattedValue
        protein.value = food.protein.formattedValue
        fat.value = food.fat.formattedValue

        colors.value = AppTheme.getRandomGradient() 
    }
}

// MARK: - Double to string

extension Double {
    var formattedValue: String? {

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2

        return formatter.string(from: NSNumber(value: self))
    }
}
