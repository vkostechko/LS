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
    @IBOutlet private weak var mainInfoContainerView: GradientView!
    @IBOutlet private weak var infoView: InfoView!
    @IBOutlet private weak var caloriesLabel: UILabel!
    @IBOutlet private weak var caloriesSubtitleLabel: UILabel!

    @IBOutlet private weak var carbsInfoView: InfoView!
    @IBOutlet private weak var proteinInfoView: InfoView!
    @IBOutlet private weak var fatInfoView: InfoView!

    @IBOutlet private weak var moreButton: UIButton!

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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)

        switch motion {
        case .motionShake:
            viewModel.didShakeDevice()

        default: break
        }
    }

    // MARK: - Actions

    @IBAction func moreButtonDidTap(_ sender: Any) {
        viewModel.didTapDetailsButton()
    }

    @IBAction func historyButtonDidTap(_ sender: Any) {
        viewModel.didTapHistoryButton()
    }

    // MARK: - Private

    private func prepareUI() {
        var theme = AppTheme()

        infoView.titleLabel.font = theme.subTitleFont
        infoView.titleLabel.textColor = theme.titleTextColor
        infoView.spacing = 6.0

        infoView.deviderView.backgroundColor = theme.deviderColor

        [carbsInfoView, proteinInfoView, fatInfoView].forEach { infoView in
            infoView?.titleLabel.font = theme.descriptionFont
            infoView?.titleLabel.textColor = theme.descriptionTextColor

            infoView?.subtitleLabel.font = theme.descriptionFont
            infoView?.subtitleLabel.textColor = theme.descriptionTextColor

            infoView?.deviderView.backgroundColor = theme.descriptionDeviderColor
        }

        infoView.subtitleLabel.isHidden = true

        caloriesLabel.font = theme.titleFont
        caloriesLabel.textColor = theme.titleTextColor

        caloriesSubtitleLabel.font = theme.subTitleFont
        caloriesSubtitleLabel.textColor = theme.subTitleTextColor

        moreButton.titleLabel?.font = theme.subTitleFont
        moreButton.tintColor = theme.titleTextColor
        moreButton.applyGradient(colors: theme.buttonGradient)

        tipLabel.font = theme.subTitleFont
        tipLabel.textColor = theme.tipTextColor
        tipView.backgroundColor = theme.tipBackgroundColor
    }

    private func updateSubviewsLayout() {
        tipView.roundCorners()
        mainInfoContainerView.roundCorners()
        moreButton.roundCorners()
    }

    private func bind(to viewModel: FoodShakeViewModel) {
        tipLabel.text = viewModel.tip

        caloriesSubtitleLabel.text = viewModel.caloriesSubtitle

        carbsInfoView.titleLabel.text = viewModel.carbsTitle
        proteinInfoView.titleLabel.text = viewModel.proteinTitle
        fatInfoView.titleLabel.text = viewModel.fatTitle

        moreButton.setTitle(viewModel.moreButtonTitle, for: .normal)

        viewModel.tipStatus.observe(on: self) { [weak self] status in
            self?.updateTip(status: status)
        }

        viewModel.error.observe(on: self) { [weak self] error in
            self?.handle(error: error)
        }

        viewModel.isDataLoaded.observe(on: self) { [weak self] loaded in
            self?.foodCardView.isHidden = !loaded
        }

        viewModel.foodName.observe(on: self) { [weak self] value in
            self?.infoView.titleLabel.text = value
        }

        viewModel.calories.observe(on: self) { [weak self] value in
            self?.caloriesLabel.text = value
        }

        viewModel.carbs.observe(on: self) { [weak self] value in
            self?.carbsInfoView.subtitleLabel.text = value
        }

        viewModel.protein.observe(on: self) { [weak self] value in
            self?.proteinInfoView.subtitleLabel.text = value
        }

        viewModel.fat.observe(on: self) { [weak self] value in
            self?.fatInfoView.subtitleLabel.text = value
        }

        viewModel.colors.observe(on: self) { [weak self] colors in
            self?.mainInfoContainerView.colors = colors
        }

        viewModel.hasHistory.observe(on: self) { [weak self] hasHitory in
            self?.updateHistoryButton(hasHistory: hasHitory)
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

// MARK: - History

private extension FoodShakerViewController {

    func updateHistoryButton(hasHistory: Bool?) {
        if hasHistory ?? false {
            showHistoryButton()
        } else {
            hideHistoryButton()
        }
    }

    func showHistoryButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icHistory"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(historyButtonDidTap(sender:)))
    }

    func hideHistoryButton() {
        navigationItem.rightBarButtonItem = nil
    }

    @objc func historyButtonDidTap(sender: Any) {
        viewModel.didTapDetailsButton()
    }
}
