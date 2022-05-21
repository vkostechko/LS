//
//  FoodProductRepository.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import Foundation

protocol FoodProductRepository {
    typealias ProductId = Int

    @discardableResult
    func fetchProduct(id: ProductId,
                      completion: @escaping (Result<FoodProduct, Error>) -> Void) -> Cancellable?
}
