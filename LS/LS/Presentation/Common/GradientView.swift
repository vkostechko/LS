//
//  GradientView.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import UIKit

class GradientView: UIView {

    var colors: [UIColor]? {
        didSet {
            updateGradient()
        }
    }

    private var gradientLayer: CAGradientLayer?

    private func updateGradient() {
        gradientLayer?.removeFromSuperlayer()

        guard let colors = colors else {
            return
        }

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.compactMap { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = bounds

        layer.insertSublayer(gradientLayer, at:0)

        self.gradientLayer = gradientLayer
    }
}
