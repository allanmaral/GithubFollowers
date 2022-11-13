//
//  GFButton.swift
//  GHFollowers
//
//  Created by Allan Amaral on 24/09/22.
//

import UIKit

class GFButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configure()
    }

    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)

        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }

    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.white, for: .normal)
    }
}
