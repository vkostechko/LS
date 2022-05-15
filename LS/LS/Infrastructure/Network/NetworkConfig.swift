//
//  NetworkConfig.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/15/22.
//

import Foundation

public struct NetworkConfig {
    public let baseURL: URL
    public let headers: [String: String]
    public let queryParameters: [String: String]
}

extension NetworkConfig: NetworkConfigurable {}
