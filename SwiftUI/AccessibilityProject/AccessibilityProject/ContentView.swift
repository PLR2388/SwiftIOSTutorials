//
//  ContentView.swift
//  AccessibilityProject
//
//  Created by Paul-Louis Renard on 25/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    /*let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Forzen tree buds",
        "SunFlowers",
        "Fireworks"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)*/
    
    @State private var value = 10
    
    var body: some View {
        VStack {
            Text("Value: \(value)")
            
            Button("Increment") {
                value += 1
            }
            
            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled")
            }
        }
        
        /*VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Your score is 1000")*/
        
        
        /*Image(decorative: "character") // Voice-over ignore it
            .accessibilityHidden(true)*/
        
        
        /*VStack {
            Image(pictures[selectedPicture])
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    selectedPicture = Int.random(in: 0...3)
                }
                .accessibilityLabel(labels[selectedPicture])
                .accessibilityAddTraits(.isButton)
                .accessibilityRemoveTraits(.isImage)
        }
        .padding()*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
