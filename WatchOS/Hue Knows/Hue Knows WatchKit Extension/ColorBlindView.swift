//
//  ColorBlindView.swift
//  Hue Knows WatchKit Extension
//
//  Created by Paul-Louis Renard on 10/09/2021.
//

import SwiftUI

struct ColorBlindView: View {
    let shapes = [
        "Seal": Image(systemName: "seal"),
        "Circle": Image(systemName: "circle"),
        "Capsule": Image(systemName: "capsule"),
        "Oval": Image(systemName: "oval"),
        "Square": Image(systemName: "square"),
        "Triangle": Image(systemName: "triangle")
    ]
    
    
    @State private var shapeKeys = ["Seal", "Circle", "Capsule", "Oval", "Square", "Triangle"]
    @State private var correctAnswer = 0
    @State private var currentLevel = 0
    @State private var gameOver = false
    @State private var title = ""
    @State private var startTime = Date()
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                text(for: 0)
                text(for: 1)
            }
            
            HStack(spacing: 10) {
                text(for: 2)
                text(for: 3)
            }
        }
        .navigationTitle(title)
        .onAppear(perform: startNewGame)
        .sheet(isPresented: $gameOver) {
            VStack {
                Text("You win!")
                    .font(.largeTitle)
                Text("You finished in \(Int(Date().timeIntervalSince(startTime))) seconds.")
                Button("Play Again", action: startNewGame)
            }
        }
    }
    
    func text(for index: Int) -> some View {
        let title : String
        
        if index == correctAnswer {
            title = shapeKeys[shapeKeys.count - 1]
        } else {
            title = shapeKeys[index]
        }
        
        
        
        return VStack {
            Text(title)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(20)

            shapes[shapeKeys[index]]
        } .onTapGesture {
            tapped(index)
        }
    }
    
    func createLevel() {
        title = "Level \(currentLevel)/10"
        correctAnswer = Int.random(in: 0...3)
        shapeKeys.shuffle()
    }
    
    func startNewGame() {
        currentLevel = 1
        gameOver = false
        startTime = Date()
        createLevel()
    }
    
    func tapped(_ index: Int) {
        if index == correctAnswer {
            currentLevel += 1
            if currentLevel == 11 {
                gameOver = true
            }
        } else {
            if currentLevel > 1 {
                currentLevel -= 1
            }
        }
        createLevel()
    }

}

struct ColorBlindView_Previews: PreviewProvider {
    static var previews: some View {
        ColorBlindView()
    }
}
