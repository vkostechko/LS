//
//  Requestable.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/15/22.
//

import Foundation

public enum HTTPMethodType: String {
    case get = "GET"
}

enum RequestGenerationError: Error {
    case components
}

public protocol Requestable {
    var path: String { get }
    var method: HTTPMethodType { get }
    var queryParametersEncodable: Encodable? { get }

    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

extension Requestable {

    public func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = config.headers
        return urlRequest
    }

    func url(with config: NetworkConfigurable) throws -> URL {
        let baseURL = config.baseURL.absoluteString.last != "/" ? config.baseURL.absoluteString + "/" : config.baseURL.absoluteString
        let endpoint = baseURL.appending(path)

        guard var urlComponents = URLComponents(string: endpoint) else {
            throw RequestGenerationError.components
        }
        var urlQueryItems = [URLQueryItem]()
        if let queryParameters = try queryParametersEncodable?.toDictionary() {
            queryParameters.forEach {
                urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
            }
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else {
            throw RequestGenerationError.components
        }
        return url
    }
}

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

public protocol ResponseRequestable: Requestable {
    associatedtype Response

    var responseDecoder: ResponseDecoder { get }
}

// MARK: - Encodable

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let josnData = try JSONSerialization.jsonObject(with: data)
        return josnData as? [String : Any]
    }
}
