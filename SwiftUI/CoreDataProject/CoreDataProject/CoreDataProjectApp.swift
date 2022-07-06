//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Paul-Louis Renard on 05/07/2022.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let container = 
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, <#T##value: V##V#>)
        }
    }
}
