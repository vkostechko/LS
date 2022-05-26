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
    
    func makeFoodShakerViewController(actions: FoodShakeViewModelActions?) -> FoodShakerViewController {
        let vc = FoodShakerViewController.loadFromNib()

        let repository = FoodProductRepositoryImpl(dataTransferService: dependencies.dataTransferService,
                                                   storage: foodStorage)
        let useCase = ShakeProductUseCaseImpl(repository: repository)
        vc.viewModel = FoodShakeViewModel(useCase: useCase, actions: actions)

        return vc
    }

    func makeFoodDetailsViewController() -> FoodDetailsViewController {
        let vc = FoodDetailsViewController.loadFromNib()
        return vc
    }

    func makeHistoryViewController() -> HistoryViewController {
        let vc = HistoryViewController.loadFromNib()
        
        let repository = HistoryRepositoryImpl(storage: foodStorage)
        let useCase = HistoryUseCaseImpl(repository: repository)
        vc.viewModel = HistoryViewModel(useCase: useCase)

        return vc
    }
}
