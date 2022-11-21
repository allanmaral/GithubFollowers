//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 19/11/22.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    let avatarImageView = GFAvatarImageView()
    let usernameLabel = GFLabel(style: .title(fontSize: 34))
    let nameLabel = GFLabel(style: .secondaryTitle(fontSize: 18))
    let locationImageView = UIImageView()
    let locationLabel = GFLabel(style: .secondaryTitle(fontSize: 18))
    let bioLabel = GFLabel(style: .body())

    private let kTextImagePadding: CGFloat = 12

    var user: User

    required init(user: User) {
        self.user = user

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure() {
        configureAvatar()
        configureUsernameLabel()
        configureNameLabel()
        configureLocationImageView()
        configureLocationLabel()
        configureBioLabel()
    }

    private func configureAvatar() {
        view.addSubview(avatarImageView)

        avatarImageView.downloadImage(from: user.avatarURL)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }

    private func configureUsernameLabel() {
        view.addSubview(usernameLabel)

        usernameLabel.text = user.login

        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(
                equalTo: avatarImageView.trailingAnchor,
                constant: kTextImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38)
        ])
    }

    private func configureNameLabel() {
        view.addSubview(nameLabel)

        nameLabel.text = user.name ?? ""

        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: kTextImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func configureLocationImageView() {
        view.addSubview(locationImageView)

        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.image = .locationSymbol
        locationImageView.tintColor = .secondaryLabel

        NSLayoutConstraint.activate([
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(
                equalTo: avatarImageView.trailingAnchor,
                constant: kTextImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func configureLocationLabel() {
        view.addSubview(locationLabel)

        locationLabel.text = user.location ?? "No Location"

        NSLayoutConstraint.activate([
            locationLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func configureBioLabel() {
        view.addSubview(bioLabel)

        bioLabel.text = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3

        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: kTextImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}
