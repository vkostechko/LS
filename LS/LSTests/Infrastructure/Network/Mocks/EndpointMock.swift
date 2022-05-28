//
//  EndpointMock.swift
//  LSTests
//
//  Created by Viachaslau Kastsechka on 5/28/22.
//

import Foundation

struct EndpointMock: Requestable {
    var path: String
    var method: HTTPMethodType
    var queryParametersEncodable: Encodable?
}
