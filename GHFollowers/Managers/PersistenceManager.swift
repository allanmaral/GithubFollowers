//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Allan Amaral on 27/11/22.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard

    enum Keys {
        static let favorites = "favorites"
    }

    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completion: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let retrievedFavorites):
                var favorites = retrievedFavorites

                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else { return completion(.alreadyInFavorites) }

                    favorites.append(favorite)

                case .remove:
                    favorites.removeAll(where: { $0.login == favorite.login })
                }

                completion(save(favorites: favorites))

            case .failure(let error):
                completion(error)
            }
        }
    }

    static func retrieveFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            return completion(.success([]))
        }

        do {
            let favorites = try JSONDecoder().decode([Follower].self, from: favoritesData)
            return completion(.success(favorites))
        } catch {
            return completion(.failure(.unableToFavorite))
        }
    }

    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
