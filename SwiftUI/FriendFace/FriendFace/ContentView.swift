//
//  ContentView.swift
//  FriendFace
//
//  Created by Paul-Louis Renard on 21/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State var users: [User] = [User]()
    var body: some View {
        NavigationView {
            List(users, id: \.self) { user in
                NavigationLink("\(user.name)" + (user.isActive ? "🟢" : "🔴")) {
                    UserDetails(user: user)
                }
            }
        }
        .task {
            if users.isEmpty {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let response = try? decoder.decode([User].self, from: data) {
                users = response
            }
        } catch {
            print("Invalid data")
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
}
