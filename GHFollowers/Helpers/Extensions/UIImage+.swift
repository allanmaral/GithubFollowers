//
//  UIImage+.swift
//  GHFollowers
//
//  Created by Allan Amaral on 02/11/22.
//

import UIKit

extension UIImage {
    public static var appLogo: UIImage {
        // swiftlint:disable:next force_unwrapping
        return UIImage(named: "gh-logo")!
    }

    public static var emptyStateLogo: UIImage {
        // swiftlint:disable:next force_unwrapping
        return UIImage(named: "empty-state-logo")!
    }
}
