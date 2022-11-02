//
//  Follower.swift
//  GHFollowers
//
//  Created by Allan Amaral on 14/10/22.
//

import Foundation

struct Follower: Codable {
  var login: String
  var avatarURL: String

  enum CodingKeys: String, CodingKey {
    case login = "login"
    case avatarURL = "avatar_url"
  }
}
