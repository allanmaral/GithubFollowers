//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Allan Amaral on 24/09/22.
//

import UIKit

class FavoritesListVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue

        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                print(favorites)

            case .failure(let error):
                print(error)
            }
        }
    }
}
