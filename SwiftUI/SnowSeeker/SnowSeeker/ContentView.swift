//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Paul-Louis Renard on 29/01/2023.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

enum FilterMode {
    case alphabetical, country, none
}

/*struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}*/

struct ContentView: View {
    //@State private var selectedUser: User? = nil
    //@State private var isShowingUser = false
    
    //@Environment(\.horizontalSizeClass) var sizeClass
    
    /*@State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]*/
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    
    @State private var isShowingSortAlert = false
    @State private var filterMode: FilterMode = .none
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite ressort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Button {
                    isShowingSortAlert = true
                } label: {
                    Image(systemName: "list.bullet")
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        .alert("Sort", isPresented: $isShowingSortAlert) {
            Button {
                filterMode = .alphabetical
            } label: {
                Text("Alphabetical")
            }
            Button {
                filterMode = .country
            } label: {
                Text("Country")
            }
        }
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts.sorted { lhs, rhs in
                switch filterMode {
                case .none:
                    return true
                case .country:
                    return lhs.country < rhs.country
                case .alphabetical:
                    return lhs.name < rhs.name
                }
            }
        } else {
            return resorts
                .filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                .sorted { lhs, rhs in
                    switch filterMode {
                    case .none:
                        return true
                    case .country:
                        return lhs.country < rhs.country
                    case .alphabetical:
                        return lhs.name < rhs.name
                    }
                }
        }
    }
    
    /*NavigationView {
        List(filteredNames, id: \.self) { name in
            Text(name)
        }
        Text("Searching for \(searchText)")
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
    }*/
        /*if sizeClass == .compact {
            VStack(content: UserView.init)
        } else {
            HStack(content: UserView.init)
        }*/

        
        
        /*Text("Hello, world!")
            .padding()
            .onTapGesture {
                selectedUser = User()
                isShowingUser = true
            }
            .alert("Welcome", isPresented: $isShowingUser) {}
            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
                Text(user.id)
            }*/
            /*.sheet(item: $selectedUser) { user in
                Text(user.id)
            }*/
        
        /*NavigationView {
            NavigationLink {
                Text("New secondary")
            } label: {
                Text("Hello, world!")
            }
                .navigationTitle("Primary")
            
            Text("Secondary")

            Text("Tertiary")
        }*/
    /*}
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter{ $0.localizedCaseInsensitiveContains(searchText)}
        }
    }*/
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
