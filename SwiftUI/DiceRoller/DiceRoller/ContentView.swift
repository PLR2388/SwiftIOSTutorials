//
//  ContentView.swift
//  DiceRoller
//
//  Created by Paul-Louis Renard on 28/01/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            Button {
                viewModel.rollDice()
            } label: {
                Text("Roll the dice")
            }
            
            Section("Previous result") {
                List(0..<viewModel.pastResults.count, id: \.self) { index in
                    let reverseIndex = viewModel.pastResults.count - 1 - index
                    HStack {
                        Text("Attempt #\(reverseIndex + 1)")
                        Spacer()
                        Text("\(viewModel.pastResults[reverseIndex])")
                    }
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
