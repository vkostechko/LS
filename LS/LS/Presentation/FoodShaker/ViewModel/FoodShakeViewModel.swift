//
//  FoodShakeViewModel.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import Foundation

final class FoodShakeViewModel {

    private let useCase: FoodShakeUseCase

    init(useCase: FoodShakeUseCase) {
        self.useCase = useCase
    }
}

// MARK: - Actions

extension FoodShakeViewModel {

    func didShakeDevice() {
        useCase.getRandomProduct { [weak self] result in
            guard let self = self else { return }
            // TODO: handle result
            print("did load product")
        }
    }
}

