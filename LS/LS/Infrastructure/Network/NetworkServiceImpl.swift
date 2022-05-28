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
    private let logger: NetworkLogger

    public init(config: NetworkConfigurable,
                sessionManager: NetworkSessionManager,
                logger: NetworkLogger) {
        
        self.config = config
        self.sessionManager = sessionManager
        self.logger = logger
    }
}

// MARK: - NetworkService

extension NetworkServiceImpl: NetworkService {

    @discardableResult
    public func request(endpoint: Requestable,
                        completion: @escaping CompletionHandler) -> NetworkCancellable? {
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
        let sessionDataTask = sessionManager.request(request) { [weak self] data, response, requestError in
            guard let self = self else { return }

            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: data)
                } else {
                    error = requestError.toNetworkError()
                }

                self.logger.log(error: error)
                completion(.failure(error))

            } else {
                self.logger.log(responseData: data, response: response)
                completion(.success(data))
            }
        }

        logger.log(request: request)

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
