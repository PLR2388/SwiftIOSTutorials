//
//  ContentView.swift
//  iMove WatchKit Extension
//
//  Created by Paul-Louis Renard on 11/09/2021.
//

import SwiftUI
import HealthKit

struct ContentView: View {

    
    let activities: [(name: String, type: HKWorkoutActivityType)] = [
        ("Cycling", .cycling),
        ("Running", .running),
        ("Wheelchair", .wheelchairRunPace)
    ]
    
    @State private var selectedActivity = 0
    
    // StateObject must be used by struct CREATING the dataManager
    // State always refers to a element from the current view
    @StateObject var dataManager = DataManager()
    
    var body: some View {
        if dataManager.state == .inactive {
            VStack {
                Picker("Choose an activity", selection: $selectedActivity) {
                    ForEach(0..<activities.count) { index in
                        Text(activities[index].name)
                    }
                }
                
                Button("Start Workout") {
                    guard HKHealthStore.isHealthDataAvailable() else { return }
                    
                    dataManager.activity = activities[selectedActivity].type
                    dataManager.start()
                }
            }
        } else {
            WorkoutView(dataManager: dataManager)
        }
   
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
