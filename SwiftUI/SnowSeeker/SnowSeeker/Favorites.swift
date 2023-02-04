//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Paul-Louis Renard on 29/01/2023.
//

import Foundation


class Favorites: ObservableObject {
    private var resorts: Set<String>
    private var savePath: URL =
        FileManager.documentsDirectory.appendingPathComponent("Favorites")
    
    
    init() {
        // load out saved data
        do {
            let data = try Data(contentsOf: savePath)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            print(error.localizedDescription)
            resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write out our data
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
