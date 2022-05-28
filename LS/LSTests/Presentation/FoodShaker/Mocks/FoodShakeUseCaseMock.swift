//
//  FoodShakeUseCaseMock.swift
//  LSTests
//
//  Created by Viachaslau Kastsechka on 5/28/22.
//

import XCTest

enum FoodShakeUseCaseMockError: Error {
    case testError
}

class FoodShakeUseCaseMock: FoodShakeUseCase {

    var cachedProduct: FoodProduct? = nil
    var product: FoodProduct?
    var error: Error?
    var expectation: XCTestExpectation?

    func getRandomProduct(cached: @escaping (FoodProduct) -> Void,
                          completion: @escaping (Result<FoodProduct, Error>) -> Void) -> Cancellable? {

        if let error = error {
            completion(.failure(error))
        } else if let product = product {
            completion(.success(product))
        } else {
            completion(.failure(FoodShakeUseCaseMockError.testError))
        }

        expectation?.fulfill()
        return nil
    }


}
