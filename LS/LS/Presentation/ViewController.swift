//
//  ViewController.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/15/22.
//

import UIKit

class ViewController: UIViewController {

    var dataTransferService: DataTransferService!
    var networkService: NetworkService!
    var dataTransferServie: DataTransferService!

    override func viewDidLoad() {
        super.viewDidLoad()

        let networkConfig = NetworkConfig(baseURL: URL(string: "https://api.lifesum.com/")!,
                                          headers: ["Authorization": "23863708:465c0554fd00da006338c72e282e939fe6576a25fd00c776c0fbe898c47c9876"])

        networkService = NetworkServiceImpl(config: networkConfig,
                                            sessionManager: NetworkSessionManagerImpl(),
                                            logger: NetworkLoggerImpl())
        dataTransferServie = DataTransferServiceImpl(with: networkService)
    }


    @IBAction func testButtonDidTap(sender: Any) {
        let endpoint = APIEndpoints.getFoodProduct(with: FoodProductRequestDTO(foodId: 1))
        dataTransferServie.request(with: endpoint) { result in
            print(result)
        }
    }
}

