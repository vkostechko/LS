//
//  AppRouter.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import Foundation
import UIKit

protocol AppRouter {
    func show(_ vc: UIViewController, animated: Bool)
}

extension AppRouter {
    func show(_ vc: UIViewController) {
        show(vc, animated: true)
    }
}

final class AppRouterImpl {
    let navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

extension AppRouterImpl: AppRouter {
    func show(_ vc: UIViewController, animated: Bool) {
        navigationController?.show(vc, sender: nil)
    }
}
