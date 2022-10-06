//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Paul-Louis Renard on 05/10/2022.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var cachedUser: CachedUser
    
    public var wrappedId: String {
        id ?? ""
    }
    
    public var wrappedName: String {
        name ?? ""
    }

}

extension CachedFriend : Identifiable {

}

extension CachedFriend {
    func toFriend() ->Friend {
        Friend(id: wrappedId, name: wrappedName)
    }
}
