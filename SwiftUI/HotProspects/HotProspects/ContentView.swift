//
//  ContentView.swift
//  HotProspects
//
//  Created by Paul-Louis Renard on 07/01/2023.
//

import SwiftUI

/*@MainActor class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}*/

struct ContentView: View {
    //@StateObject var user = User()
    @State private var selectedTab = "One"
    
    var body: some View {
        /*VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)*/
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    selectedTab = "Two"
                }
                .tabItem {
                    Label("One", systemImage: "star")
                }
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
