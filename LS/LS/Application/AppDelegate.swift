//
//  AppDelegate.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/15/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private(set) var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = UINavigationController()
        window?.rootViewController = rootViewController

        AppAppearance.setupAppearance()

        appCoordinator = AppCoordinator(appAssembly: AppAssembly(),
                                        appRouter: AppRouterImpl(navigationController: rootViewController))
        appCoordinator.start()

        window?.makeKeyAndVisible()

        return true
    }
}

