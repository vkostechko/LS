//
//  FoodShakerViewController.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import UIKit

class FoodShakerViewController: UIViewController {

    var viewModel: FoodShakeViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions

    @IBAction func shakeButtonDidTap(_ sender: Any) {
        viewModel.didShakeDevice()
    }
}
