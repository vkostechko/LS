//
//  FoodProductRepository.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import Foundation

typealias ProductId = Int

protocol FoodProductRepository {

    @discardableResult
    func fetchProduct(id: ProductId,
                      cached: @escaping (FoodProduct) -> Void,
                      completion: @escaping (Result<FoodProduct, Error>) -> Void) -> Cancellable?
}
