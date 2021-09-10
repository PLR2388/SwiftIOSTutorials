//
//  ContentView.swift
//  NoteDictate WatchKit Extension
//
//  Created by Paul-Louis Renard on 09/09/2021.
//

import SwiftUI

struct ContentView: View {
    
    // Thanks to State, one can modify notes inside the body
    // and it updates the view every time notes change
    //It should never be share amongs views
    @State private var notes = [Note]()
    @State private var text = ""
    
    var body: some View {
        VStack {
            // $ sign means read and write value from text property. Not $ sign means read only ($ = binding)
            HStack {
                TextField("Add new notes", text: $text)
                Button {
                    guard text .isEmpty == false else {return}
                    
                    
                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                    
                    text = ""
                } label : {
                    Image(systemName: "plus")
                        .padding()
                } .fixedSize() // Avoid having HStack to split equally elements
                .buttonStyle(BorderedButtonStyle(tint: .blue))
                 
                NavigationLink(
                    destination: CreditsView(),
                    label: {
                        Image(systemName: "exclamationmark.circle")
                            .padding()
                    })
                    .buttonStyle(BorderedButtonStyle(tint: .blue))
                    .fixedSize()
                
               
            }
//            List(notes) { note in
//                Text(note.text)
//            }
            // Need an id to uniquely identify element in List
//            List(0..<notes.count, id: \.self) { i in
//                NavigationLink(
//                    destination: DetailView(index: i, note: notes[i])) {
//                    Text(notes[i].text)
//                        .lineLimit(1)
//                }
//
//            }
            // Use For Each to have a dynamic list with deletable objects (here just an array inside the list)
            List {
                ForEach(0..<notes.count, id: \.self) { i in
                    NavigationLink(
                        destination: DetailView(index: i, note: notes[i], totalNumber: notes.count)) {
                        Text(notes[i].text)
                            .lineLimit(1)
                    }
                }
                .onDelete(perform: delete)
            }
        }
        .navigationTitle("NoteDictate")
    }
    
    // IndexSet is a array of number in which number are >=0 and unique
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
