//
//  GFLabel.swift
//  GHFollowers
//
//  Created by Allan Amaral on 19/11/22.
//

import UIKit

struct GFLabelStyle {
    let textColor: UIColor
    let textAlignment: NSTextAlignment
    let adjustsFontSizeToFitWidth: Bool
    let minimumScaleFactor: CGFloat
    let lineBreakMode: NSLineBreakMode
    let font: UIFont
}

class GFLabel: UILabel {
    var style: GFLabelStyle? {
        didSet {
            guard let style = style else { return }
            apply(style)
        }
    }

    init(style: GFLabelStyle) {
        super.init(frame: .zero)

        self.style = style
        apply(style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func apply(_ style: GFLabelStyle) {
        translatesAutoresizingMaskIntoConstraints = false

        textColor = style.textColor
        textAlignment = style.textAlignment
        adjustsFontSizeToFitWidth = style.adjustsFontSizeToFitWidth
        minimumScaleFactor = style.minimumScaleFactor
        lineBreakMode = style.lineBreakMode
        font = style.font
    }
}
