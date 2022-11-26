//
//  UIViewController+SafariVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 26/11/22.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
