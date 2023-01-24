//
//  FileManager.swift
//  HotProspects
//
//  Created by Paul-Louis Renard on 24/01/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
