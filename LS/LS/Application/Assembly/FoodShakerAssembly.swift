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

    lazy var foodStorage: FoodStorage = { FoodStorageImpl() }()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func makeFoodShakerCoordinator(router: AppRouter) -> FoodShakerCoordinator {
        FoodShakerCoordinator(router: router, dependencies: self)
    }
}

// MARK: - FoodShakerCoordinatorDependencies

extension FoodShakerAssembly: FoodShakerCoordinatorDependencies {
    func makeFoodShakerViewController() -> FoodShakerViewController {
        let vc = FoodShakerViewController.loadFromNib()

        let repository = FoodProductRepositoryImpl(dataTransferService: dependencies.dataTransferService,
                                                   storage: foodStorage)
        let useCase = ShakeProductUseCaseImpl(repository: repository)
        vc.viewModel = FoodShakeViewModel(useCase: useCase)

        return vc
    }
}
