//
//  AppAssembly.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import Foundation

final class AppAssembly {

    private(set) lazy var appConfiguration = AppConfiguration()

    private(set) lazy var dataTransferService: DataTransferService = {
        let config = NetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!,
                                   headers: ["Authorization": appConfiguration.authToken])

        let networkService = NetworkServiceImpl(config: config,
                                                sessionManager: NetworkSessionManagerImpl(),
                                                logger: NetworkLoggerImpl())

        return DataTransferServiceImpl(with: networkService)
    }()

    func makeFoodShakerAssembly() -> FoodShakerAssembly {
        let dependencies = FoodShakerAssembly.Dependencies(dataTransferService: dataTransferService)
        return FoodShakerAssembly(dependencies: dependencies)
    }
}
