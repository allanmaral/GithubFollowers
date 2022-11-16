//
//  User.swift
//  GHFollowers
//
//  Created by Allan Amaral on 14/10/22.
//

import Foundation

struct User: Decodable {
    let login: String
    let avatarURL: String
    let name: String?
    let location: String?
    let bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlURL: String
    let following: Int
    let followers: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarURL = "avatar_url"
        case name = "name"
        case location = "location"
        case bio = "bio"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case htmlURL = "html_url"
        case following = "following"
        case followers = "followers"
        case createdAt = "created_at"
    }
}
