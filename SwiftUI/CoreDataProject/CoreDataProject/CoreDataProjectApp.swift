//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Paul-Louis Renard on 05/07/2022.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
