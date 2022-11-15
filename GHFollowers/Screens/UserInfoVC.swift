//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 15/11/22.
//

import UIKit

class UserInfoVC: UIViewController {
    var username: String

    required init (username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        configureNavigation()
    }

    private func configureNavigation() {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }

    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}
