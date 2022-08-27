//
//  User.swift
//  FriendFace
//
//  Created by Paul-Louis Renard on 21/08/2022.
//

import Foundation

struct User: Codable, Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
