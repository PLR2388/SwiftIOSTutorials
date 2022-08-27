//
//  UserDetails.swift
//  FriendFace
//
//  Created by Paul-Louis Renard on 27/08/2022.
//

import SwiftUI

struct UserDetails: View {
    let user: User
    
    var body: some View {
        VStack {
            HStack {
                Text("Name")
                Spacer()
                Text(user.name)
            }
            HStack {
                Text("Age")
                Spacer()
                Text("\(user.age)")
            }
            HStack {
                Text("Company")
                Spacer()
                Text(user.company)
            }
            HStack {
                Text("Email")
                Spacer()
                Text(user.email)
            }
            HStack {
                Text("Address")
                Spacer()
                Text(user.address)
            }
            HStack {
                Text("About")
                Spacer()
                Text(user.about)
            }
            HStack {
                Text("Registered")
                Spacer()
                Text("\(user.registered)")
            }
            HStack {
                Text("Friends")
                Spacer()
                VStack {
                    ForEach(user.friends, id: \.self) {
                        Text($0.name)
                    }
                }
            }
        }
    }
}
