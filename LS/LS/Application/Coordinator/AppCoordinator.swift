//
//  AppCoordinator.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import Foundation

final class AppCoordinator {

    let appAssembly: AppAssembly
    let appRouter: AppRouter

    init(appAssembly: AppAssembly, appRouter: AppRouter) {
        self.appAssembly = appAssembly
        self.appRouter = appRouter
    }

    func start() {
        let productAssembly = appAssembly.makeFoodShakerAssembly()
        let flow = productAssembly.makeFoodShakerCoordinator(router: appRouter)
        flow.start()
    }
}
