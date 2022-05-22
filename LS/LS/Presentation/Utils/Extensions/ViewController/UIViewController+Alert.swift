//
//  UIViewController+Alert.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import UIKit

extension UIViewController {

    func showError(title: String? = L10n("alert.error"),
                   message: String? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        let okAction = UIAlertAction(title: L10n("alert.ok"),
                                     style: .default)
        alert.addAction(okAction)

        present(alert, animated: true)
    }

}
