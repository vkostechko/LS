//
//  FoodShakerCoordinator.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import UIKit

final class FoodShakerCoordinator {

    let router: AppRouter

    init(router: AppRouter) {
        self.router = router
    }

    func start() {
        let vc = FoodShakerViewController.loadFromNib()
        router.show(vc)
    }
}
