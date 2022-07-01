//
//  ContentView.swift
//  HabbitTracking
//
//  Created by Paul-Louis Renard on 27/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    
    @StateObject private var activities = Activities()
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.activities, id: \.id) { activity in
                    CustomRowView(title: activity.title, subtitle: activity.description, repetition: activity.repetition)
                    
                }
            }
            .toolbar {
                Button {
                    isPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .navigationTitle("Habbit Tracking")
            .sheet(isPresented: $isPresented) {
                AddHabbit { activity in
                    activities.addElement(activity: activity)
                    isPresented = false
                }
            }
        }
    }
}

struct AddHabbit: View {
    @State private var name: String = ""
    @State private var description: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    let saveCompletion: (Activity) -> Void
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Description", text: $description)
            Button("Add") {
                if !name.isEmpty && !description.isEmpty {
                    let activity = Activity(id: UUID(), title: name, description: description, repetition: 0)
                    saveCompletion(activity)
                    presentationMode.wrappedValue.dismiss()
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

private struct CustomRowView: View {
  var title: String
  var subtitle: String
  var repetition: Int
  
  var body: some View {
      HStack {
          VStack(alignment: .leading) {
            Text(title)
              .font(.headline)
            Text(subtitle)
              .font(.subheadline)
          }
          Spacer()
          Text("\(repetition)")
      }

  }
}
