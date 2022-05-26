//
//  HistoryItemCell.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/26/22.
//

import UIKit

class HistoryItemCell: UICollectionViewCell {

    @IBOutlet private weak var foodNameLabel: UILabel!
    @IBOutlet private weak var caloriesInfoLabel: UILabel!
    @IBOutlet private weak var progressView: UIView!
    @IBOutlet private weak var fatInfoLabel: UILabel!
    @IBOutlet private weak var containerView: GradientView!

    static let reuseIdentifier = "HistoryItemCell"

    var viewModel: HistoryItemViewModel? {
        didSet {
            if let viewModel = viewModel {
                bind(viewModel: viewModel)
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        progressView.roundCorners(8.0)
        containerView.roundCorners(16.0)
    }

    private func bind(viewModel: HistoryItemViewModel) {
        viewModel.foodName.observe(on: self) { [weak self] value in
            self?.foodNameLabel.text = value
        }

        viewModel.calories.observe(on: self) { [weak self] value in
            self?.caloriesInfoLabel.text = value
        }

        viewModel.fat.observe(on: self) { [weak self] value in
            self?.fatInfoLabel.text = value
        }

        viewModel.colors.observe(on: self) { [weak self] colors in
            self?.containerView.colors = colors
        }
    }
}
