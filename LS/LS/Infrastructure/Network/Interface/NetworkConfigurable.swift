//
//  NetworkConfigurable.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/15/22.
//

import Foundation

public protocol NetworkConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
}
