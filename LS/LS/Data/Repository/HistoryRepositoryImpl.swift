//
//  HistoryRepositoryImpl.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/26/22.
//

import Foundation

public final class HistoryRepositoryImpl {
    private let storage: FoodStorage

    init(storage: FoodStorage) {
        self.storage = storage
    }
}

extension HistoryRepositoryImpl: HistoryRepository {

    func fetchHistory(completion: @escaping (Result<HistoryItem?, Error>) -> Void) -> Cancellable? {
        storage.getHistory { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO?.toDomain()))

            case .failure(let error):
                completion(.failure(error))
            }
//            if case let .success(responseDTO?) = result {
//
//            }
        }
        return nil
    }
}
