//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Allan Amaral on 20/11/22.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let titleLabel = GFLabel(style: .title(fontSize: 14, textAlignment: .left))
    let countLabel = GFLabel(style: .title(fontSize: 14, textAlignment: .center))

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(itemType: ItemInfoType, withCount count: Int) {
        switch itemType {
        case .repos:
            symbolImageView.image = .folderSymbol
            titleLabel.text = "Public Repos"

        case .gists:
            symbolImageView.image = .textAlignLeftSymbol
            titleLabel.text = "Public Gists"

        case .followers:
            symbolImageView.image = .personSymbol
            titleLabel.text = "Followers"

        case .following:
            symbolImageView.image = .heartSymbol
            titleLabel.text = "Following"
        }
        
        countLabel.text = String(count)
    }

    private func configure() {
        configureSymbolImage()
        configureTitle()
        configureCount()
    }

    private func configureSymbolImage() {
        addSubview(symbolImageView)

        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label

        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func configureTitle() {
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    private func configureCount() {
        addSubview(countLabel)

        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

}
