//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 23/11/22.
//

import UIKit

class GFItemInfoVC: UIViewController {
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()

    let kPadding: CGFloat = 20

    var user: User
    weak var delegate: UserInfoVCDelegate?

    required init(user: User, delegate: UserInfoVCDelegate?) {
        self.user = user
        self.delegate = delegate

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
        configureContainer()
        configureItemViews()
        configureActionButton()
    }

    private func configureContainer() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }

    private func configureItemViews() {
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: kPadding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: kPadding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -kPadding),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureActionButton() {
        view.addSubview(actionButton)

        actionButton.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -kPadding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: kPadding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -kPadding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc func didTapAction() { }
}
