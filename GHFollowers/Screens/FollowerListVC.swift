//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 12/10/22.
//

import UIKit

class FollowerListVC: UIViewController {
  var username: String?

  override func viewDidLoad() {
    super.viewDidLoad()

    title = username
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .systemBackground

    NetworkManager.shared.getFollowers(for: username ?? "", page: 1) { result in
      switch result {
      case .success(let followers):
        print("Followers.count = \(followers.count)")
        print(followers)

      case .failure(let error):
        self.presentAlert(title: "Bad Stuff Happened", message: error.rawValue, actionText: "OK")
      }
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.setNavigationBarHidden(false, animated: true)
  }
}
