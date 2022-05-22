//
//  UIView+Gradient.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/23/22.
//

import UIKit

extension UIView {

    @discardableResult
    func applyGradient(colors: [UIColor]?,
                       locations: [NSNumber]? = nil,
                       startPoint: CGPoint? = nil,
                       endPoint: CGPoint? = nil) -> CAGradientLayer {

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors?.map { $0.cgColor }
        if let startPoint = startPoint {
            gradientLayer.startPoint = startPoint
        }
        if let endPoint = endPoint {
            gradientLayer.endPoint = endPoint
        }
        gradientLayer.locations = locations
        gradientLayer.frame = bounds

        layer.insertSublayer(gradientLayer, at: 0)

        return gradientLayer
    }
}
