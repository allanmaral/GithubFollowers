//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 23/11/22.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure() {
        configureItems()
        configureAction()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemType: .gists, withCount: user.publicGists)
    }

    private func configureAction() {
        actionButton.set(title: "Github Profile", style: .purple)
    }
}
