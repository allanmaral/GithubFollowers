//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 24/09/22.
//

import UIKit

class SearchVC: UIViewController {
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let submitSearchButton = GFButton(title: "Get Followers")

    var isUsernameValid: Bool {
        return UsernameValidator.validate(usernameTextField.text ?? "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func configureView() {
        view.backgroundColor = .systemBackground

        configureLogoImageView()
        configureTextField()
        configureSearchButton()
        configureTapRecognizer()
    }

    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = .appLogo

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func configureTextField() {
        view.addSubview(usernameTextField)

        usernameTextField.delegate = self

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureSearchButton() {
        view.addSubview(submitSearchButton)

        submitSearchButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            submitSearchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            submitSearchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            submitSearchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            submitSearchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureTapRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapRecognizer)
    }

    @objc private func pushFollowerListVC() {
        guard isUsernameValid else {
            presentAlert(
                title: "Invalid Username",
                message: "Please enter a valid username. We need to know who to look for ????.",
                actionText: "OK!")
            return
        }

        let followerListVC = FollowerListVC()
        followerListVC.username = usernameTextField.text ?? ""

        navigationController?.pushViewController(followerListVC, animated: true)
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
