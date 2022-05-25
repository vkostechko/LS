//
//  FoodShakerCoordinator.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import UIKit

protocol FoodShakerCoordinatorDependencies  {
    func makeFoodShakerViewController(actions: FoodShakeViewModelActions?) -> FoodShakerViewController
    func makeFoodDetailsViewController() -> FoodDetailsViewController
    func makeHistoryViewController() -> HistoryViewController
}

final class FoodShakerCoordinator {

    let router: AppRouter
    let dependencies: FoodShakerCoordinatorDependencies

    init(router: AppRouter, dependencies: FoodShakerCoordinatorDependencies) {
        self.router = router
        self.dependencies = dependencies
    }

    func start() {
        let actions = FoodShakeViewModelActions(showDetails: showMovieDetails(foodProduct:),
                                                showHistory: showHistory)
        let vc = dependencies.makeFoodShakerViewController(actions: actions)
        router.show(vc)
    }

    private func showMovieDetails(foodProduct: FoodProduct) {
        let vc = dependencies.makeFoodDetailsViewController()
        router.show(vc)
    }

    private func showHistory() {
        let vc = dependencies.makeHistoryViewController()
        router.show(vc)
    }
}
