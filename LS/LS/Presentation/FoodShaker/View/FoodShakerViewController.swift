//
//  FoodShakerViewController.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import UIKit

class FoodShakerViewController: UIViewController {

    var viewModel: FoodShakeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func shakeButtonDidTap(_ sender: Any) {
        viewModel.useCase.getRandomProduct { result in
            print("did finish")
        }
    }
}
