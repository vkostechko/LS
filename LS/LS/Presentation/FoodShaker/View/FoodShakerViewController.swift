//
//  FoodShakerViewController.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/21/22.
//

import UIKit

class FoodShakerViewController: UIViewController {

    @IBOutlet private weak var tipView: UIView!
    @IBOutlet private weak var tipLabel: UILabel!

    @IBOutlet private weak var foodCardView: UIView!
    @IBOutlet private weak var mainInfoContainerView: UIView!
    @IBOutlet private weak var infoView: InfoView!
    @IBOutlet private weak var caloriesLabel: UILabel!
    @IBOutlet private weak var caloriesSubtitleLabel: UILabel!

    @IBOutlet private weak var carbsInfoView: InfoView!
    @IBOutlet private weak var proteinInfoView: InfoView!
    @IBOutlet private weak var fatInfoView: InfoView!

    @IBOutlet weak var moreButton: UIButton!

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

    @IBAction func moreButtonDidTap(_ sender: Any) {

    }

    // MARK: - Private

    private func prepareUI() {

    }

    private func updateSubviewsLayout() {
        tipView.roundCorners()
        mainInfoContainerView.roundCorners()
    }

    private func bind(to viewModel: FoodShakeViewModel) {
        tipLabel.text = viewModel.tip

        caloriesSubtitleLabel.text = viewModel.caloriesSubtitle

        carbsInfoView.titleLabel.text = viewModel.carbsTitle
        proteinInfoView.titleLabel.text = viewModel.proteinTitle
        fatInfoView.titleLabel.text = viewModel.fatTitle

        viewModel.tipStatus.observe(on: self) { [weak self] status in
            self?.updateTip(status: status)
        }

        viewModel.error.observe(on: self) { [weak self] error in
            self?.handle(error: error)
        }

        viewModel.isDataLoaded.observe(on: self) { [weak self] loaded in
            //self?.foodCardView.isHidden = !loaded
        }
    }
}

// MARK: - Tip

private extension FoodShakerViewController {
    func updateTip(status: FoodShakeViewModel.TipStatus?) {
        guard let status = status else { return }

        switch status {
        case .animating:
            animateTip()

        case .hidden:
            hideTip()
        }
    }

    func animateTip() {
        tipView.shake()
    }

    func hideTip() {
        tipView.disappear()
    }
}

// MARK: - Error

private extension FoodShakerViewController {

    func handle(error: String?) {
        guard let error = error else {
            return
        }
        showError(error)
    }

    func showError(_ error: String?) {
        showError(message: error)
    }
}
