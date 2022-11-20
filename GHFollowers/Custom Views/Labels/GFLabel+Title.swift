//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by Allan Amaral on 12/10/22.
//

import UIKit

extension GFLabelStyle {
    static func title(fontSize: CGFloat, textAlignment: NSTextAlignment) -> GFLabelStyle {
        GFLabelStyle(
            textColor: .label,
            textAlignment: textAlignment,
            adjustsFontSizeToFitWidth: true,
            minimumScaleFactor: 0.9,
            lineBreakMode: .byTruncatingTail,
            font: .systemFont(ofSize: fontSize, weight: .semibold))
    }
}
