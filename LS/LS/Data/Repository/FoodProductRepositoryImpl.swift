//
//  FoodProductRepositoryImpl.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import Foundation

public final class FoodProductRepositoryImpl {

    private let dataTransferService: DataTransferService

    public init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - FoodProductRepository

extension FoodProductRepositoryImpl: FoodProductRepository {

    @discardableResult
    func fetchProduct(id: ProductId,
                      completion: @escaping (Result<FoodProduct, Error>) -> Void) -> Cancellable? {

        let requestDTO = FoodProductRequestDTO(foodId: id)
        let endpoint = APIEndpoints.getFoodProduct(with: requestDTO)

        return dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
