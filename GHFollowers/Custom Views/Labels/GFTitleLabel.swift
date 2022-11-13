//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by Allan Amaral on 12/10/22.
//

import UIKit

class GFTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(fontSize: CGFloat, textAlignment: NSTextAlignment = .left) {
        super.init(frame: .zero)

        self.textAlignment = textAlignment
        self.font = .systemFont(ofSize: fontSize, weight: .semibold)
        configure()
    }

    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
