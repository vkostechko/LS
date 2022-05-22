//
//  FoodShakeUseCase.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import Foundation

protocol FoodShakeUseCase {
    func getRandomProduct(completion: @escaping (Result<FoodProduct, Error>) -> Void)
}

final class ShakeProductUseCaseImpl {
    private let repository: FoodProductRepository

    init(repository: FoodProductRepository) {
        self.repository = repository
    }
}

extension ShakeProductUseCaseImpl: FoodShakeUseCase {

    func getRandomProduct(completion: @escaping (Result<FoodProduct, Error>) -> Void) {
        let productId = ProductId.random(in: 1...10)
        repository.fetchProduct(id: productId, completion: completion)
    }
}
