//
//  DetailView.swift
//  NoteDictate WatchKit Extension
//
//  Created by Paul-Louis Renard on 10/09/2021.
//

import SwiftUI

struct DetailView: View {
    let index: Int
    let note: Note
    let totalNumber: Int
    
    var body: some View {
        Text(note.text)
            .navigationTitle("Note \(index + 1)/\(totalNumber)")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(index: 1, note: Note(id: UUID(), text: "Hello, World!"), totalNumber: 5)
    }
}
