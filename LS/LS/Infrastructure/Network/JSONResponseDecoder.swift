//
//  JSONResponseDecoder.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/17/22.
//

import Foundation

public final class JSONResponseDecoder {
    private lazy var jsonDecoder: JSONDecoder = { JSONDecoder() }()
}

// MARK: - ResponseDecoder

extension JSONResponseDecoder: ResponseDecoder {
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
