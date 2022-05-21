//
//  ViewController.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/15/22.
//

import UIKit

class ViewController: UIViewController {

    var repository: FoodProductRepository!

    override func viewDidLoad() {
        super.viewDidLoad()

        let networkConfig = NetworkConfig(baseURL: URL(string: "https://api.lifesum.com/")!,
                                          headers: ["Authorization": "23863708:465c0554fd00da006338c72e282e939fe6576a25fd00c776c0fbe898c47c9876"])

        let networkService = NetworkServiceImpl(config: networkConfig,
                                            sessionManager: NetworkSessionManagerImpl(),
                                            logger: NetworkLoggerImpl())

        let dataTransferServie = DataTransferServiceImpl(with: networkService)

        repository = FoodProductRepositoryImpl(dataTransferService: dataTransferServie)
    }


    @IBAction func testButtonDidTap(sender: Any) {
        repository.fetchProduct(id: 1) { result in
            print(result)
        }
    }
}

