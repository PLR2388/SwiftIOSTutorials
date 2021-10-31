//
//  Country.swift
//  Project13-15
//
//  Created by Paul-Louis Renard on 31/10/2021.
//

import Foundation

struct Country: Codable {
    var name: String
    var population: Int
    var language: String
    
    var descriptionCountry: String {
        return "\(name) have \(population) inhabitants and talk \(language)"
    }
}
