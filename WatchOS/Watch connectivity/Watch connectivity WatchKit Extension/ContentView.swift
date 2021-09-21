//
//  ContentView.swift
//  Watch connectivity WatchKit Extension
//
//  Created by Paul-Louis Renard on 11/09/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var connectivity = Connectivity()
    
    var body: some View {
        VStack{
            Text(connectivity.receivedText)
            Button("Message", action: sendMessage)
        }
    }
    
    func sendMessage() {
        let data = ["text": "Hello from the watch"]
        connectivity.transferUserInfo(data)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
