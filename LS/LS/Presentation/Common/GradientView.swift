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
        gradientLayer = applyGradient(colors: colors,
                                      startPoint: CGPoint(x: 0, y: 0),
                                      endPoint: CGPoint(x: 0.5, y: 1))
    }
}
