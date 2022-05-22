//
//  CrewMemberView.swift
//  Moonshot
//
//  Created by Paul-Louis Renard on 21/05/2022.
//

import SwiftUI

struct CrewMemberView: View {
    let crewMember: CrewMember
    
    var body: some View {
        HStack {
            Image(crewMember.astronaut.id)
                .resizable()
                .frame(width: 104, height: 72)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(.white, lineWidth: 1)
                )
            VStack(alignment: .leading) {
                Text(crewMember.astronaut.name)
                    .foregroundColor(.white)
                    .font(.headline)
                
                Text(crewMember.role)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
}

struct CrewMemberView_Previews: PreviewProvider {
    static var previews: some View {
        CrewMemberView(crewMember: CrewMember(role: "DrugDealer", astronaut: Astronaut(id: "", name: "", description: "")))
    }
}
