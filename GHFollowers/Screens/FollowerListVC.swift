//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 12/10/22.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollower(for username: String)
}

class FollowerListVC: UIViewController {
    enum Section {
        case main
    }

    var username: String? {
        didSet {
            title = username
        }
    }
    var unfilteredFollowers: [Follower] = []
    var followers: [Follower] = [] {
        didSet {
            updateData()
        }
    }

    var page = 1
    var hasMoreFollowers = true
    var collectionView: UICollectionView?
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureNavigation()
        configureCollectionView()
        configureDataSource()
        configureSearchController()
        getFollowers(for: username, in: page)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }

    private func configureNavigation() {
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }

    private func configureCollectionView() {
        let collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UIHelpers.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        self.collectionView = collectionView
    }

    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"

        navigationItem.searchController = searchController
    }

    private func getFollowers(for username: String?, in page: Int) {
        showLoadingView()

        NetworkManager.shared.getFollowers(for: username ?? "", page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.unfilteredFollowers.append(contentsOf: followers)
                if self.unfilteredFollowers.isEmpty {
                    DispatchQueue.main.async {
                        let message = "This user doesn't have any followers. Go follow them ????."
                        self.showEmptySateView(with: message, in: self.view)
                    }
                    return
                }
                self.followers = self.unfilteredFollowers

            case .failure(let error):
                self.presentAlert(title: "Bad Stuff Happened", message: error.rawValue, actionText: "OK")
            }
        }
    }

    private func configureDataSource() {
        guard let collectionView = collectionView else { return }

        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
            collectionView: collectionView) { collectionView, indexPath, follower in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowerCell.reuseID,
                    for: indexPath) as? FollowerCell
                else { return nil }

                cell.display(follower: follower)
                return cell
        }
    }

    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource?.apply(snapshot, animatingDifferences: true) }
    }

    @objc func addButtonTapped() {
        guard let username = username else { return }
        showLoadingView()

        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarURL: user.avatarURL)
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }

                    guard let error = error else {
                        return self.presentAlert(
                            title: "Success!",
                            message: "You have successfully favorited this user ????",
                            actionText: "Hooray!")
                    }

                    self.presentAlert(title: "Something went wrong", message: error.rawValue, actionText: "Ok")
                }

            case .failure(let error):
                self.presentAlert(title: "Something went wrong", message: error.rawValue, actionText: "Ok")
            }
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - (3 * height) {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(for: username, in: page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = followers[indexPath.item]
        let userInfoVC = UserInfoVC(username: follower.login, delegate: self)
        let navController = UINavigationController(rootViewController: userInfoVC)

        present(navController, animated: true)
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text?.lowercased() else { return }

        followers = filter.isEmpty
            ? unfilteredFollowers
            : unfilteredFollowers.filter { $0.login.lowercased().contains(filter) }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        followers = unfilteredFollowers
    }
}

extension FollowerListVC: FollowerListVCDelegate {
    func didRequestFollower(for username: String) {
        self.username = username
        self.page = 1
        unfilteredFollowers.removeAll()
        followers.removeAll()
        getFollowers(for: username, in: page)
    }
}
