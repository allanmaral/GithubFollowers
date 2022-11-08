//
//  UsernameValidator.swift
//  GHFollowers
//
//  Created by Allan Amaral on 12/10/22.
//

import Foundation

public final class UsernameValidator {
    private static let instance = UsernameValidator()

    private var regex: NSRegularExpression

    private init() {
        // swiftlint:disable:next force_try
        self.regex = try! NSRegularExpression(pattern: "^[A-Za-z0-9](?:[A-Za-z0-9]|(?:-(?!-)))*$")
    }

    static func validate(_ username: String) -> Bool {
        let range = NSRange(location: 0, length: username.utf16.count)
        let isValid = instance.regex.firstMatch(in: username, options: [], range: range) != nil
        return isValid
    }
}
