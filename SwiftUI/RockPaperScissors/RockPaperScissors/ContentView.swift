//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Paul-Louis Renard on 10/01/2022.
//

import SwiftUI

enum GameOption: String {
    case Rock = "Rock"
    case Paper = "Paper"
    case Scissors = "Scissors"
}

struct ContentView: View {
    let choices: [GameOption] = [.Rock, .Paper, .Scissors]
    @State private var turnChoice = Int.random(in: 0...2)
    @State private var mustWin = Bool.random()
    @State private var alertTitle = ""
    @State private var score = 0
    @State private var displayAlert = false
    @State private var currentQuestionNumber = 0
    @State private var isGameOver = false
    
    
    var body: some View {
        VStack {
            Spacer()
            Text(choices[turnChoice].rawValue)
                .font(.largeTitle)
            Text(mustWin ? "Win!" : "Lose!")
                .font(.subheadline)
            Spacer()
            HStack {
                Spacer()
                Button(GameOption.Rock.rawValue) {
                    checkAnswer(optionChoosed: .Rock)
                }
                Spacer()
                Button(GameOption.Paper.rawValue) {
                    checkAnswer(optionChoosed: .Paper)
                }
                Spacer()
                Button(GameOption.Scissors.rawValue) {
                    checkAnswer(optionChoosed: .Scissors)
                }
                Spacer()
            }
            Spacer()
        }
        .alert(alertTitle, isPresented: $displayAlert) {
            Button("Ok") {
                nextQuestion()
            }
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game Over", isPresented: $isGameOver) {
            Button("Restart") {
                restartGame()
            }
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    private func restartGame() {
        turnChoice = Int.random(in: 0...2)
        mustWin = Bool.random()
        currentQuestionNumber = 0
        score = 0
    }
    
    private func nextQuestion() {
        turnChoice = Int.random(in: 0...2)
        mustWin = Bool.random()
        currentQuestionNumber += 1
        
        if currentQuestionNumber == 10 {
            isGameOver = true
        }
    }
    
    private func checkAnswer(optionChoosed: GameOption) {
        let playerHasWon: Bool
        if mustWin {
            switch choices[turnChoice] {
            case .Scissors:
                playerHasWon = optionChoosed == .Rock
            case .Paper:
                playerHasWon = optionChoosed == .Scissors
            case .Rock:
                playerHasWon = optionChoosed == .Paper
            }
        } else {
            switch choices[turnChoice] {
            case .Scissors:
                playerHasWon = optionChoosed == .Paper
            case .Paper:
                playerHasWon = optionChoosed == .Rock
            case .Rock:
                playerHasWon = optionChoosed == .Scissors
            }
        }
        
        if playerHasWon {
            alertTitle = "You won"
            score += 1
        } else {
            alertTitle = "You lose"
            score -= 1
        }
        displayAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
