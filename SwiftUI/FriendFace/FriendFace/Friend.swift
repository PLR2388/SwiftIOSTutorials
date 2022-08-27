//
//  Friend.swift
//  FriendFace
//
//  Created by Paul-Louis Renard on 21/08/2022.
//

import Foundation

struct Friend: Codable, Hashable {
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    var id: String
    var name: String
}
