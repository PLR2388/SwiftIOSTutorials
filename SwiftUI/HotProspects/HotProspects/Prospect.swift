//
//  Prospect.swift
//  HotProspects
//
//  Created by Paul-Louis Renard on 23/01/2023.
//

import SwiftUI

enum Sort {
    case none, date, name
}

class Prospect: Identifiable, Codable {
    var id = UUID()
    var creationDate = Date()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPeople")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
        }
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func sort(by sort: Sort) {
        objectWillChange.send()
        people.sort { a, b in
            switch sort {
            case .none:
                return a.id < b.id
            case .name:
                return a.name < b.name
            case .date:
                return a.creationDate < b.creationDate
            }
        }
    }
    
    func toggle(_ propect: Prospect) {
        objectWillChange.send()
        propect.isContacted.toggle()
        save()
    }
}
