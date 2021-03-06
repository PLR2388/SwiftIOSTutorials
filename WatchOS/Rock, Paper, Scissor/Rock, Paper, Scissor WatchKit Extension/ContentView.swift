//
 //  ContentView.swift
 //  Rock, Paper, Scissor WatchKit Extension
 //
 //  Created by Paul-Louis Renard on 10/09/2021.
 //

 import SwiftUI

 struct ContentView: View {


     @State private var question = "rock"
     @State private var title = "Win!"
     @State private var shouldWin = true
     @State private var level = 1
     @State private var currentTime = Date()
     @State private var startTime = Date()
     @State private var gameOver = false
    
     @State private var isAnswerCorrect = false
     @State private var shouldDisplayAlert = false

     let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()

     @State var moves = ["rock", "paper", "scissors"]


     var time: String {
         let difference = currentTime.timeIntervalSince(startTime)
         return String(Int(difference))
     }

     var body: some View {
         VStack {
             if gameOver {
                 Text("You win!")
                     .font(.largeTitle)
                 Text("Your time: \(time) seconds")

                 Button("Play Again") {
                     startTime = Date()
                     gameOver = false
                     level = 1
                     newLevel()
                 }
                 .buttonStyle(BorderedButtonStyle(tint: .green))
             } else {
                 Image(question)
                     .resizable()
                     .scaledToFit()
                 Divider()
                     .padding(.vertical)
                 HStack {
                     ForEach(moves, id: \.self) { type in
                         Button {
                             select(move: type)
                         } label: {
                             Image(type)
                                 .resizable()
                                 .scaledToFit()
                         }
                         .buttonStyle(PlainButtonStyle())
                     }
                 }
                 HStack {
                     Text("\(level)/20")
                     Spacer()
                     Text("Time: \(time)")
                 }
                 .padding([.top,.horizontal])
             }
         }
         .navigationTitle(title)
         .onAppear(perform: newLevel)
         .onReceive(timer) { newTime in
             guard gameOver == false else { return }
             currentTime = newTime
         }
         .sheet(isPresented: $shouldDisplayAlert) {
            VStack {
                isAnswerCorrect ? Text("Correct!") : Text("Incorrect!")
            }
         }
     }

     func select(move: String) {
         let solutions = [
             "rock": (win: "paper", lose: "scissors"),
             "paper": (win: "scissors", lose: "rock"),
             "scissors": (win: "rock", lose: "paper")
         ]
         guard let answer = solutions[question] else {
             fatalError("Unknown question: \(question)")
         }

         let isCorrect: Bool

         if shouldWin {
             isCorrect = move == answer.win
         } else {
             isCorrect = move == answer.lose
         }
        
        isAnswerCorrect = isCorrect
        shouldDisplayAlert = true

         if isCorrect {
             level += 1
         } else {
             level -= 1
             if level < 1 {
                 level = 1
             }
         }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            shouldDisplayAlert = false
            newLevel()
        }
     }

     func newLevel() {
         if level == 21 {
             gameOver = true
             return
         }

         if Bool.random() {
             title = "Win!"
             shouldWin = true
         } else {
             title = "Lose!"
             shouldWin = false
         }

         let newArray = moves.filter { elt in
             elt != question
         }

         question = newArray.randomElement()!
         moves.shuffle()
     }
 }

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
     }
 }
