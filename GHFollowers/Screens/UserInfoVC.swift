//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 15/11/22.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFLabel(style: .body(textAlignment: .center))

    let kPadding: CGFloat = 20
    let kItemHeight: CGFloat = 140

    var username: String
    weak var delegate: FollowerListVCDelegate?

    required init (username: String, delegate: FollowerListVCDelegate?) {
        self.username = username
        self.delegate = delegate
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
        configureDateLabel()
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
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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

    private func configureDateLabel() {
        view.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: kPadding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: kPadding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -kPadding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    private func getUser() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElement(with: user)
                }

            case .failure(let error):
                self.presentAlert(title: "Bad Stuff Happened", message: error.rawValue, actionText: "OK")
            }
        }
    }

    private func configureUIElement(with user: User) {
        add(childVC: GFRepoItemVC(user: user, delegate: self), to: itemViewOne)
        add(childVC: GFFollowerItemVC(user: user, delegate: self), to: itemViewTwo)
        add(childVC: GFUserInfoHeaderVC(user: user), to: headerView)

        guard let createdAt = Date.from(string: user.createdAt)?.convertToMonthYearFormat() else { return }
        self.dateLabel.text = "Github since \(createdAt)"
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

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlURL) else {
            return presentAlert(
                title: "Invalid URL",
                message: "The url attached to this user is invalid.",
                actionText: "Ok!")
        }

        presentSafariVC(with: url)
    }

    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            return presentAlert(
                title: "No followers",
                message: "This user has no followers. What a shame 😞.",
                actionText: "So sad")
        }

        delegate?.didRequestFollower(for: user.login)
        dismissViewController()
    }
}
