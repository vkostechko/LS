//
//  NetworkSessionManager.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/17/22.
//

import Foundation

final class NetworkSessionManagerImpl {
}

// MARK: - NetworkSessionManager

extension NetworkSessionManagerImpl: NetworkSessionManager {

    public func request(_ request: URLRequest,
                        completion: @escaping CompletionHandler) -> NetworkCancellable {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
