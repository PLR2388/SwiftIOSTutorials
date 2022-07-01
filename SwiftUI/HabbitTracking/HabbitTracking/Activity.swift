//
//  Activity.swift
//  HabbitTracking
//
//  Created by Paul-Louis Renard on 04/06/2022.
//

import Foundation

struct Activity: Codable, Identifiable {
    let id: UUID
    let title: String
    let description: String
    var repetition: Int
}
