//
//  RepositoryTask.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/24/22.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false

    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
