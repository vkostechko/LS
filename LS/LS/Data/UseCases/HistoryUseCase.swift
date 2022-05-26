//
//  HistoryUseCase.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/26/22.
//

import Foundation

protocol HistoryUseCase {
    @discardableResult
    func getHistory(completion: @escaping (Result<HistoryItem?, Error>) -> Void) -> Cancellable?
}

final class HistoryUseCaseImpl {

    private let repository: HistoryRepository

    init(repository: HistoryRepository) {
        self.repository = repository
    }
}

// MARK: - HistoryUseCase

extension HistoryUseCaseImpl: HistoryUseCase {

    @discardableResult
    func getHistory(completion: @escaping (Result<HistoryItem?, Error>) -> Void) -> Cancellable? {
        repository.fetchHistory(completion: completion)
    }
}
