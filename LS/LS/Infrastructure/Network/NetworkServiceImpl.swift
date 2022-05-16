//
//  NetworkServiceImpl.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/15/22.
//

import Foundation

public final class NetworkServiceImpl {

    private let config: NetworkConfigurable
    private let sessionManager: NetworkSessionManager

    public init(config: NetworkConfigurable,
                sessionManager: NetworkSessionManager) {
        self.config = config
        self.sessionManager = sessionManager
    }
}

// MARK: - NetworkService

extension NetworkServiceImpl: NetworkService {
    public func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> NetworkCancellable? {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(.urlGeneration))
            return nil
        }
    }
}

// MARK: - Private

private extension NetworkServiceImpl {
    func request(request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {
        let sessionDataTask = sessionManager.request(request) { data, response, requestError in
            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: data)
                } else {
                    error = requestError.toNetworkError()
                }

                completion(.failure(error))
            } else {
                completion(.success(data))
            }
        }

        return sessionDataTask
    }
}

// MARK: - Error + NetworkError

private extension Error {

    func toNetworkError() -> NetworkError {
        let code = URLError.Code(rawValue: (self as NSError).code)
        switch code {
        case .notConnectedToInternet:
            return .notConnected

        case .cancelled:
            return .cancelled

        default:
            return .generic(self)
        }
    }
}
