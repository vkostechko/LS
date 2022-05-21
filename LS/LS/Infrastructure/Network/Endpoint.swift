//
//  Endpoint.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/15/22.
//

import Foundation

public final class Endpoint<R>: ResponseRequestable {

    public typealias Response = R

    public let path: String
    public let method: HTTPMethodType
    public let queryParametersEncodable: Encodable?
    
    public let responseDecoder: ResponseDecoder
    
    init(path: String,
         method: HTTPMethodType,
         queryParametersEncodable: Encodable?,
         responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
        self.path = path
        self.method = method
        self.queryParametersEncodable = queryParametersEncodable
        self.responseDecoder = responseDecoder
    }
}
