//
//  NetworkConfigurableMock.swift
//  LSTests
//
//  Created by Viachaslau Kastsechka on 5/28/22.
//

import Foundation

class NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://test.com")!
    var headers: [String : String] = [:]
}
