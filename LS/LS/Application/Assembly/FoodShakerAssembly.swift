//
//  FoodShakerAssembly.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import Foundation

final class FoodShakerAssembly {
    
    struct Dependencies {
        let dataTransferService: DataTransferService
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func makeFoodShakerCoordinator(router: AppRouter) -> FoodShakerCoordinator {
        FoodShakerCoordinator(router: router)
    }
}
