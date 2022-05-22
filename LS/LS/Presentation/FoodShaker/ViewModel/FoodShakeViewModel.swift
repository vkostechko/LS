//
//  FoodShakeViewModel.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import Foundation

final class FoodShakeViewModel {

    let useCase: FoodShakeUseCase

    init(useCase: FoodShakeUseCase) {
        self.useCase = useCase
    }
}
