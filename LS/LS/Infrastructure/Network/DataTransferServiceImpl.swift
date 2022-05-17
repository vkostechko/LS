//
//  DataTransferServiceImpl.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/17/22.
//

import Foundation

final class DataTransferServiceImpl {

    private let networkService: NetworkService

    public init(with networkService: NetworkService) {
        self.networkService = networkService
    }
}

// MARK: - DataTransferService

extension DataTransferServiceImpl: DataTransferService {

    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E,
                                                       completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where E.Response == T {
        networkService.request(endpoint: endpoint) { [weak self] responseResult in
            guard let self = self else { return }
            switch responseResult {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(data: data,
                                                                       decoder: endpoint.responseDecoder)
                DispatchQueue.main.async { completion(result) }

            case .failure(let networkError):
                DispatchQueue.main.async {
                    completion(.failure(.networkFailure(networkError)))
                }
            }
        }
    }
}

// MARK: - Private

private extension DataTransferServiceImpl {

    private func decode<T: Decodable>(data: Data?,
                                      decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        guard let data = data else {
            return .failure(.noResponse)
        }

        do {
            let result: T = try decoder.decode(data)
            return .success(result)

        } catch {
            return .failure(.parsing(error))
        }
    }
}
