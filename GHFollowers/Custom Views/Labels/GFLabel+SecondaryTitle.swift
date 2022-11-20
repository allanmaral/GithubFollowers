//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Allan Amaral on 19/11/22.
//

import UIKit

extension GFLabelStyle {
    static func secondaryTitle(fontSize: CGFloat) -> GFLabelStyle {
        GFLabelStyle(
            textColor: .secondaryLabel,
            textAlignment: .left,
            adjustsFontSizeToFitWidth: true,
            minimumScaleFactor: 0.90,
            lineBreakMode: .byTruncatingTail,
            font: .systemFont(ofSize: fontSize, weight: .medium))
    }
}
