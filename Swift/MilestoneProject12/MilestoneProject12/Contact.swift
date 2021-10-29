//
//  Contact.swift
//  MilestoneProject12
//
//  Created by Paul-Louis Renard on 29/10/2021.
//

import Foundation

class Contact: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
