//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 12/10/22.
//

import UIKit

class FollowerListVC: UIViewController {
    enum Section {
        case main
    }

    var username: String?
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var collectionView: UICollectionView?
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
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
        title = username
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
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
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    DispatchQueue.main.async {
                        let message = "This user doesn't have any followers. Go follow them 😄."
                        self.showEmptySateView(with: message, in: self.view)
                    }
                    return
                }
                self.updateData(with: self.followers)

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

    private func updateData(with followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource?.apply(snapshot, animatingDifferences: true) }
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
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text?.lowercased() else { return }

        filteredFollowers = filter.isEmpty ? followers : followers.filter { $0.login.lowercased().contains(filter) }
        updateData(with: filteredFollowers)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(with: followers)
    }
}
