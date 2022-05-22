//
//  FoodShakerViewController.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import UIKit

class FoodShakerViewController: UIViewController {

    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var tipLabel: UILabel!

    var viewModel: FoodShakeViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        bind(to: viewModel)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.viewDidAppear()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        updateSubviewsLayout()
    }

    // MARK: - Actions

    @IBAction func shakeButtonDidTap(_ sender: Any) {
        viewModel.didShakeDevice()
    }

    // MARK: - Private

    private func prepareUI() {
        tipLabel.text = viewModel.tip
    }

    private func updateSubviewsLayout() {
        tipView.roundCorners()
    }

    private func bind(to viewModel: FoodShakeViewModel) {
        viewModel.tipStatus.observe(on: self) { [weak self] status in
            self?.updateTip(status: status)
        }

        viewModel.error.observe(on: self) { [weak self] error in
            self?.showError(error)
        }
    }

    private func updateTip(status: FoodShakeViewModel.TipStatus?) {
        guard let status = status else { return }

        switch status {
        case .animating:
            animateTip()

        case .hidden:
            hideTip()
        }
    }

    private func animateTip() {
        tipView.shake()
    }

    private func hideTip() {
        tipView.disappear()
    }

    private func showError(_ error: String?) {

    }
}
