//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Allan Amaral on 02/11/22.
//

import UIKit

class GFAvatarImageView: UIImageView {
  static var placeholderImage: UIImage = {
    // swiftlint:disable:next force_unwrapping
    UIImage(named: "avatar-placeholder")!
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    layer.cornerRadius = 10
    clipsToBounds = true
    image = GFAvatarImageView.placeholderImage
    translatesAutoresizingMaskIntoConstraints = false
  }
}
