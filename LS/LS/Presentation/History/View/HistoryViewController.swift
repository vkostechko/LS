//
//  HistoryViewController.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/26/22.
//

import UIKit

class HistoryViewController: UIViewController {

    var viewModel: HistoryViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        bind(to: viewModel)

        viewModel.viewDidLoad()
    }

    // MARK: - Private

    private func prepareUI() {
    }

    private func bind(to viewModel: HistoryViewModel) {
    }
}
