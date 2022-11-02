//
//  User.swift
//  GHFollowers
//
//  Created by Allan Amaral on 14/10/22.
//

import Foundation

struct User {
  var login: String
  var avatarURL: String
  var name: String?
  var location: String?
  var bio: String?
  var publicRepos: Int
  var publicGists: Int
  var htmlURL: String
  var following: Int
  var followers: Int
  var createdAt: String
}
