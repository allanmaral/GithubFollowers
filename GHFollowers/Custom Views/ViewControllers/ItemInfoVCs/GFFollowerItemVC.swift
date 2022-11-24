//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 23/11/22.
//

import Foundation

class GFFollowerItemVC: GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure() {
        configureItems()
        configureAction()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemType: .following, withCount: user.following)
    }

    private func configureAction() {
        actionButton.set(title: "Get Followers", style: .primary)
    }
}
