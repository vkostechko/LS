//
//  FoodProductRepositoryImpl.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import Foundation

public final class FoodProductRepositoryImpl {

    private let dataTransferService: DataTransferService
    private let storage: FoodStorage

    init(dataTransferService: DataTransferService, storage: FoodStorage) {
        self.dataTransferService = dataTransferService
        self.storage = storage
    }
}

// MARK: - FoodProductRepository

extension FoodProductRepositoryImpl: FoodProductRepository {

    @discardableResult
    func fetchProduct(id: ProductId,
                      cached: @escaping (FoodProduct) -> Void,
                      completion: @escaping (Result<FoodProduct, Error>) -> Void) -> Cancellable? {

        let task = RepositoryTask()
        let requestDTO = FoodProductRequestDTO(foodId: id)
        storage.getResponse(for: requestDTO) { [weak self] result in
            guard let self = self else { return }

            if case let .success(responseDTO?) = result {
                cached(responseDTO.toDomain())
            }

            guard !task.isCancelled else { return }

            task.networkTask = self.fetchProduct(requestDTO: requestDTO,
                                                 completion: completion) as? NetworkCancellable
        }

        return task
    }

    private func fetchProduct(requestDTO: FoodProductRequestDTO,
                              completion:  @escaping (Result<FoodProduct, Error>) -> Void) -> Cancellable? {
        let endpoint = APIEndpoints.getFoodProduct(with: requestDTO)
        return dataTransferService.request(with: endpoint) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let responseDTO):
                let foodProductDTO = responseDTO.response
                self.storage.save(response: foodProductDTO, for: requestDTO) {
                    self.storage.add(response: foodProductDTO, toHostoryFor: requestDTO)

                    completion(.success(responseDTO.toDomain()))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
