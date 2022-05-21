//
//  NetworkLoggerImpl.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import Foundation

public final class NetworkLoggerImpl {
    public init() { }
}

// MARK: - NetworkErrorLogger

extension NetworkLoggerImpl: NetworkLogger {

    public func log(request: URLRequest) {
        log(request.description)
    }

    public func log(responseData data: Data?, response: URLResponse?) {
        guard
            let data = data,
            let info = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else { return }

        log("responseData: \(info) \n response: \(response?.description ?? "undefined")")
    }

    public func log(error: Error) {
        log("\(error)")
    }
}

// MARK: - Utils

private extension NetworkLoggerImpl {
    func log(_ log: String) {
        #if DEBUG
        print(log)
        #endif
    }
}

// MARK: - URLRequest + Utils

extension URLRequest {
    var description: String {
        """
            request: \(String(describing: url))
            headers: \(String(describing: allHTTPHeaderFields))
            method: \(httpMethod ?? "undefined")
        """
    }
}
