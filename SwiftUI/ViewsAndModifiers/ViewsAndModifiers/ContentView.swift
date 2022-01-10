//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Paul-Louis Renard on 06/01/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .toLargeTitle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
