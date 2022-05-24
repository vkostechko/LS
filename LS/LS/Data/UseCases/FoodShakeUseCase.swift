//
//  FoodShakeUseCase.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import Foundation

protocol FoodShakeUseCase {
    @discardableResult
    func getRandomProduct(cached: @escaping (FoodProduct) -> Void,
                          completion: @escaping (Result<FoodProduct, Error>) -> Void) -> Cancellable?
}

final class ShakeProductUseCaseImpl {
    private let repository: FoodProductRepository

    init(repository: FoodProductRepository) {
        self.repository = repository
    }
}

extension ShakeProductUseCaseImpl: FoodShakeUseCase {

    @discardableResult
    func getRandomProduct(cached: @escaping (FoodProduct) -> Void,
                          completion: @escaping (Result<FoodProduct, Error>) -> Void) -> Cancellable? {
        let productId = ProductId.random(in: 1...10)
        return repository.fetchProduct(id: productId,
                                       cached: cached,
                                       completion: completion)
    }
}
