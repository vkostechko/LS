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

    static let reuseIdentifier = "HistoryItemCell"

    var viewModel: HistoryItemViewModel?

    override func layoutSubviews() {
        super.layoutSubviews()

        progressView.roundCorners(8.0)
    }

    func bind(viewModel: HistoryItemViewModel) {
        self.viewModel = viewModel
        
    }
}
