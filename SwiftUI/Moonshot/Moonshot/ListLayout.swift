//
//  ListLayout.swift
//  Moonshot
//
//  Created by Paul-Louis Renard on 21/05/2022.
//

import SwiftUI

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List {
                ForEach(missions) { mission in
                    NavigationLink(mission.displayName) {
                        MissionView(mission: mission, astronauts: astronauts)
                    }
            }
        }
        .listStyle(.plain)
        .listRowBackground(Color.darkBackground)
    }
}
