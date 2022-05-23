//
//  UIView+Animations.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import UIKit

extension UIView {

    func shake(duration: TimeInterval = 3.0) {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]

        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map { (degrees: Double) -> Double in
            let radians: Double = (Double.pi * degrees) / 180.0
            return radians
        }

        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.autoreverses = true
        shakeGroup.repeatCount = Float.infinity
        shakeGroup.duration = duration

        layer.add(shakeGroup, forKey: "shakeViewAnimation")
    }

    func stopAnimations() {
        layer.removeAllAnimations()
    }

    func disappear(duration: TimeInterval = 0.3) {
        let initialAlpha = alpha
        UIView.animate(withDuration: duration) {
            self.alpha = 0.0
        } completion: { finished in
            guard finished else { return }

            self.isHidden = true
            self.alpha = initialAlpha

            self.stopAnimations()
        }
    }
}
