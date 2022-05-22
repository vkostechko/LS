//
//  FoodShakeViewModel.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import Foundation

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




    private var food: FoodProduct? {
        didSet {
            isDataLoaded.value = food != nil
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
}
