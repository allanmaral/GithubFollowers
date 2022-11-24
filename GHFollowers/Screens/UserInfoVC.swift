//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 15/11/22.
//

import UIKit

class UserInfoVC: UIViewController {
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()

    let kPadding: CGFloat = 20
    let kItemHeight: CGFloat = 140

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

        configure()
        getUser()
    }

    private func configure() {
        view.backgroundColor = .systemBackground

        configureNavigation()
        configureHeader()
        configureItemViewOne()
        configureItemViewTwo()
    }

    private func configureNavigation() {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }

    private func configureHeader() {
        view.addSubview(headerView)

        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: kPadding),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: kPadding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -kPadding),
            headerView.heightAnchor.constraint(equalToConstant: 190)
        ])
    }

    private func configureItemViewOne() {
        view.addSubview(itemViewOne)

        itemViewOne.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: kPadding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: kPadding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -kPadding),
            itemViewOne.heightAnchor.constraint(equalToConstant: kItemHeight)
        ])
    }

    private func configureItemViewTwo() {
        view.addSubview(itemViewTwo)

        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: kPadding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: kPadding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -kPadding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: kItemHeight)
        ])
    }

    private func getUser() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemVC(user: user), to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemVC(user: user), to: self.itemViewTwo)
                }

            case .failure(let error):
                self.presentAlert(title: "Bad Stuff Happened", message: error.rawValue, actionText: "OK")
            }
        }
    }

    @objc private func dismissViewController() {
        dismiss(animated: true)
    }

    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)

        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
