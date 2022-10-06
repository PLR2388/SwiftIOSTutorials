//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Paul-Louis Renard on 05/10/2022.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var cachedFriend: [CachedFriend]?
    
    public var wrappedId: String {
        id ?? ""
    }
    
    public var wrappedName: String {
        name ?? ""
    }
    
    public var wrappedCompany: String {
        company ?? ""
    }
    
    public var wrappedEmail: String {
        email ?? ""
    }
    
    public var wrappedAbout: String {
        about ?? ""
    }
    
    public var wrappedRegistered: Date {
        registered ?? Date(timeIntervalSince1970: 0)
    }
    
    public var wrappedTags: [String] {
        tags?.components(separatedBy: ",") ?? []
    }
    
    public var wrappedAddress: String {
        address ?? ""
    }
}

extension CachedUser : Identifiable {

}

extension CachedUser {
    func toUser() -> User {
        User(id: wrappedId, isActive: isActive, name: wrappedName, age: Int(age), company: wrappedCompany, email: wrappedEmail, address: wrappedAddress, about: wrappedAbout, registered: wrappedRegistered, tags: wrappedTags, friends: cachedFriend.map({ elt in
            elt.toFriend()
        }))
    }
}
