//
//  ContentView.swift
//  EdutainmentMultiplicationTable
//
//  Created by Paul-Louis Renard on 26/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    let numberOfQuestionsPossibility = [5, 10, 20]
    @State var multiplicationTable = 2
    @State var learning = false
    @State var numberOfQuestions = 5
    
    @State var numberOfQuestionsAsked = 0
    @State var chosenMultiplier = Int.random(in: 1...12)
    @State var answer: Int = 0
    @State var alertPresented = false
    @State var isTrue = false
    @State var score = 0
    
    var body: some View {
        VStack {
            Text("Score: \(score)")
            if learning {
                Text("\(multiplicationTable) x \(chosenMultiplier) ?")
                TextField("Enter the result", value: $answer, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .padding()
                Button("Validate") {
             
                    isTrue = (multiplicationTable * chosenMultiplier == answer)
                    alertPresented = true
                }
            } else {
                Stepper("Learn \(multiplicationTable) Multiplication table", value: $multiplicationTable, in: 2...12)
                Picker("Number of questions", selection: $numberOfQuestions) {
                    ForEach(numberOfQuestionsPossibility, id: \.self) {
                        Text(String($0))
                    }
                }
                .pickerStyle(.segmented)
                Button("Start learning") {
                    score = 0
                    learning = true
                }
            }
        }
        .alert("Your answer is \(isTrue ? "true" : "wrong")" , isPresented: $alertPresented) {
            Button("Next") {
                if isTrue {
                    score += 1
                }
                    numberOfQuestionsAsked += 1
                    if numberOfQuestionsAsked >= numberOfQuestions {
                        learning = false
                    }
                    chosenMultiplier = Int.random(in: 1...12)
                    alertPresented = false
                  
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
