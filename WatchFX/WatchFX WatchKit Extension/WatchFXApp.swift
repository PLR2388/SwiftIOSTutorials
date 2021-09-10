//
//  WatchFXApp.swift
//  WatchFX WatchKit Extension
//
//  Created by Paul-Louis Renard on 10/09/2021.
//

import SwiftUI

@main
struct WatchFXApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
