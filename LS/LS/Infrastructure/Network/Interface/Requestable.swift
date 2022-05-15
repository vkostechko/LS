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

public protocol Requestable {
    var path: String { get }
    var method: HTTPMethodType { get }
    var headerParamaters: [String: String] { get }
    var queryParameters: [String: Any] { get }

    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

public protocol ResponseRequestable: Requestable {
    associatedtype Response

    var responseDecoder: ResponseDecoder { get }
}
