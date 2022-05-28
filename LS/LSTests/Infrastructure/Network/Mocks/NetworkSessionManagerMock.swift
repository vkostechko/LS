//
//  NetworkSessionManagerMock.swift
//  LSTests
//
//  Created by Viachaslau Kastsechka on 5/28/22.
//

import Foundation

struct NetworkSessionManagerMock: NetworkSessionManager {

    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?

    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable {
        completion(data, response, error)
        return URLSessionDataTask()
    }


}
