//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Paul-Louis Renard on 19/11/2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
