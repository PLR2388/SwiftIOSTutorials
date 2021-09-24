//
//  Person.swift
//  Project 10
//
//  Created by Paul-Louis Renard on 23/09/2021.
//

import UIKit

class Person: NSObject {

    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
