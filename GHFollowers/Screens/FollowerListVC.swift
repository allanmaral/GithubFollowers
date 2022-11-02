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
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.setNavigationBarHidden(false, animated: true)
  }
}
