//
//  FileManagerExt.swift
//  DiceRoller
//
//  Created by Paul-Louis Renard on 28/01/2023.
//

import Foundation

extension FileManager {
    
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func decode<T: Codable>(_ file: String) -> T {
        let url = FileManager.documentsDirectory.appendingPathComponent(file)
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
