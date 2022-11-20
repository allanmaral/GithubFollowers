//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Allan Amaral on 12/10/22.
//

import UIKit

extension GFLabelStyle {
    static func body(textAlignment: NSTextAlignment) -> GFLabelStyle {
        GFLabelStyle(
            textColor: .secondaryLabel,
            textAlignment: textAlignment,
            adjustsFontSizeToFitWidth: true,
            minimumScaleFactor: 0.75,
            lineBreakMode: .byWordWrapping,
            font: .preferredFont(forTextStyle: .body))
    }
}
