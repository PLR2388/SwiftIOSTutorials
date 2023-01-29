//
//  ContentView-ViewModel.swift
//  DiceRoller
//
//  Created by Paul-Louis Renard on 28/01/2023.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var pastResults = [Int]()
        
        private let savePath = FileManager.documentsDirectory.appendingPathComponent("savedResult")
        
        init() {
            loadResult()
        }
        
        func rollDice() {
            let random = Int.random(in: 1...6)
            pastResults.append(random)
            saveResult()
        }
        
        func loadResult() {
            do {
                let data = try Data(contentsOf: savePath)
                pastResults = try JSONDecoder().decode([Int].self, from: data)
            } catch {
                print(error.localizedDescription)
                pastResults = []
            }
        }
        
        func saveResult() {
            do {
                let data = try JSONEncoder().encode(pastResults)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
}
