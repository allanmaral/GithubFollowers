//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Allan Amaral on 02/11/22.
//

import UIKit

final class FollowerCell: UICollectionViewCell {
  static let reuseID = String(describing: FollowerCell.self)

  let avatarImageView = GFAvatarImageView(frame: .zero)
  let usernameLabel = GFTitleLabel(fontSize: 16, textAlignment: .center)
  let padding: CGFloat = 8

  override init(frame: CGRect) {
    super.init(frame: frame)

    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func display(follower: Follower) {
    usernameLabel.text = follower.login
  }

  private func configure() {
    configureAvatarImage()
    configureUsernameLabel()
  }

  private func configureAvatarImage() {
    contentView.addSubview(avatarImageView)

    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
      avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
    ])
  }

  private func configureUsernameLabel() {
    contentView.addSubview(usernameLabel)

    NSLayoutConstraint.activate([
      usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
      usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      usernameLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
}
