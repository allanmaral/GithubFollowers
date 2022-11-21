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

    public static var locationSymbol: UIImage {
        // swiftlint:disable:next force_unwrapping
        return UIImage(systemName: "mappin.and.ellipse")!
    }

    public static var folderSymbol: UIImage {
        // swiftlint:disable:next force_unwrapping
        return UIImage(systemName: "folder")!
    }

    public static var textAlignLeftSymbol: UIImage {
        // swiftlint:disable:next force_unwrapping
        return UIImage(systemName: "text.alignleft")!
    }

    public static var heartSymbol: UIImage {
        // swiftlint:disable:next force_unwrapping
        return UIImage(systemName: "heart")!
    }

    public static var personSymbol: UIImage {
        // swiftlint:disable:next force_unwrapping
        return UIImage(systemName: "person.2")!
    }
}
