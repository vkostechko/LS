//
//  HistoryRepository.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/26/22.
//

import Foundation

protocol HistoryRepository {

    @discardableResult
    func fetchHistory(completion: @escaping (Result<HistoryItem?, Error>) -> Void) -> Cancellable?
}
