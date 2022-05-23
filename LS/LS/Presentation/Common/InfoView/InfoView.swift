//
//  InfoView.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import UIKit

final class InfoView: NibDesignable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var deviderView: UIView!

    @IBOutlet private weak var contentView: UIStackView!

    var spacing: CGFloat = 0.0 {
        didSet {
            if contentView != nil {
                contentView.spacing = spacing
            }
        }
    }
}
