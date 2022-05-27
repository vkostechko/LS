//
//  ProgressView.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/27/22.
//

import UIKit

class ProgressView: NibDesignable {

    @IBOutlet private weak var indicatorView: UIView!
    @IBOutlet private weak var indicatorTrailingConstraint: NSLayoutConstraint!

    var progress: Float = 0 {
        didSet {
            progress = min(progress, 1.0)
            updateIndicatorView()
        }
    }

    var borderColor: UIColor? = .white {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    var progressColor: UIColor? = .blue {
        didSet {
            indicatorView.backgroundColor = progressColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.borderWidth = 1.0
        layer.borderColor = borderColor?.cgColor

        backgroundColor = .clear

        indicatorView.backgroundColor = progressColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let cornerRadius = bounds.height / 2.0

        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true

        indicatorView.layer.cornerRadius = cornerRadius
        indicatorView.layer.masksToBounds = true
    }

    private func updateIndicatorView(animated: Bool = true) {
        let indicatorWidth = bounds.width * CGFloat(progress)
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            self.indicatorTrailingConstraint.constant = self.bounds.width - indicatorWidth
            self.layoutIfNeeded()
        }
    }
}
