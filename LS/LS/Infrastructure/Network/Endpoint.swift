//
//  Endpoint.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/15/22.
//

import Foundation

public class Endpoint<R> {
    public var responseDecoder: ResponseDecoder

    public typealias Response = R

    public let path: String
    public let method: HTTPMethodType
    public let headerParamaters: [String: String]
    public let queryParameters: [String: Any]

    init(path: String,
         method: HTTPMethodType,
         headerParamaters: [String: String] = [:],
         queryParameters: [String: Any] = [:],
         responseDecoder: ResponseDecoder) {
        self.path = path
        self.method = method
        self.headerParamaters = headerParamaters
        self.queryParameters = queryParameters
        self.responseDecoder = responseDecoder
    }
}

extension Endpoint: ResponseRequestable {
    public func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest {
        return URLRequest(url: URL(string: path)!)
    }
}
