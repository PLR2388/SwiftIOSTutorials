//
//  Activities.swift
//  HabbitTracking
//
//  Created by Paul-Louis Renard on 19/06/2022.
//

import Foundation

class Activities: ObservableObject {
    @Published var activities : [Activity]
    
    init() {
        if let json = UserDefaults.standard.object(forKey: "activities") as? Data {
            let activities = try? JSONDecoder().decode([Activity].self, from: json)
            self.activities = activities ?? []
        } else {
            self.activities = []
        }
        
    }
    
    func addElement(activity: Activity) {
        self.activities.append(activity)
        if let json = try? JSONEncoder().encode(activities) {
            UserDefaults.standard.set(json, forKey: "activities")
        }
    }
}
