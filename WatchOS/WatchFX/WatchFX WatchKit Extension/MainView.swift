//
//  MainView.swift
//  WatchFX WatchKit Extension
//
//  Created by Paul-Louis Renard on 10/09/2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
            CurrenciesView()
            QuickConversion()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
