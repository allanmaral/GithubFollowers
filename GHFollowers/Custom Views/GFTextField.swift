//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Allan Amaral on 24/09/22.
//

import UIKit

class GFTextField: UITextField {
  override init(frame: CGRect) {
    super.init(frame: frame)

    configure()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    configure()
  }

  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false

    layer.cornerRadius = 10
    layer.borderWidth = 2
    layer.borderColor = UIColor.systemGray4.cgColor

    textColor = .label
    tintColor = .label
    textAlignment = .center
    font = .preferredFont(forTextStyle: .title2)
    adjustsFontSizeToFitWidth = true
    minimumFontSize = 12

    backgroundColor = .tertiarySystemBackground
    autocorrectionType = .no
    returnKeyType = .go
    autocapitalizationType = .none

    placeholder = "Enter a username"
  }
}
