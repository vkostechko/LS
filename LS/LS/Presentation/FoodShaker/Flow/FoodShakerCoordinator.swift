//
//  FoodShakerCoordinator.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import UIKit

protocol FoodShakerCoordinatorDependencies  {
    func makeFoodShakerViewController() -> FoodShakerViewController
}

final class FoodShakerCoordinator {

    let router: AppRouter
    let dependencies: FoodShakerCoordinatorDependencies

    init(router: AppRouter, dependencies: FoodShakerCoordinatorDependencies) {
        self.router = router
        self.dependencies = dependencies
    }

    func start() {
        let vc = dependencies.makeFoodShakerViewController()
        router.show(vc)
    }
}
