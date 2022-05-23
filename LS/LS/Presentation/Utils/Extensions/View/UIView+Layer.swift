//
//  UIView+Layer.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import UIKit

extension UIView {

    func roundCorners() {
        roundCorners(bounds.height / 2.0)
    }

    func roundCorners(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
