//
//  GFButton.swift
//  GHFollowers
//
//  Created by Allan Amaral on 24/09/22.
//

import UIKit

struct GFButtonStyle {
    let backgroundColor: UIColor
    let titleColor: UIColor
}

class GFButton: UIButton {
    var style: GFButtonStyle? {
        didSet {
            if let style = style {
                apply(style)
            } else {
                style = oldValue
            }
        }
    }

    init(title: String? = nil, style: GFButtonStyle = .primary) {
        super.init(frame: .zero)

        self.setTitle(title, for: .normal)
        self.style = style
        apply(style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func apply(_ style: GFButtonStyle) {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = style.backgroundColor
        setTitleColor(style.titleColor, for: .normal)
        layer.cornerRadius = 10
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
    }

    func set(title: String, style: GFButtonStyle? = nil) {
        self.setTitle(title, for: .normal)
        self.style = style
    }
}
