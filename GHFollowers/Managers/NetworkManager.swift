//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Allan Amaral on 02/11/22.
//

import Foundation
import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users"
    let cache = NSCache<NSString, UIImage>()

    private init() {}

    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = "\(baseURL)/\(username)/followers?per_page=100&page=\(page)"

        guard let url = URL(string: endpoint) else {
            return completion(.failure(.invalidUsername))
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return completion(.failure(.unableToComplete))
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return completion(.failure(.invalidResponse))
            }

            guard let data = data else {
                return completion(.failure(.invalidData))
            }

            do {
                let followers = try JSONDecoder().decode([Follower].self, from: data)
                return completion(.success(followers))
            } catch {
                return completion(.failure(.invalidData))
            }
        }

        task.resume()
    }
}
