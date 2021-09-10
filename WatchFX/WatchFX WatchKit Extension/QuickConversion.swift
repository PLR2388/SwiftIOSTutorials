//
//  QuickConversion.swift
//  WatchFX WatchKit Extension
//
//  Created by Paul-Louis Renard on 10/09/2021.
//

import SwiftUI

struct QuickConversion: View {
    
    private let amountList = [1.0, 5.0, 10.0, 25.0, 50.0, 100.0, 250.0, 500.0, 1000.0]
    
    @State private var selectedAmount = 500.0
    
    private var selectedCurrency = UserDefaults.standard.string(forKey: ContentView.previousBaseCurrencyKey) ?? "USD"
    
    var body: some View {
        VStack {
            Picker("Select a value", selection: $selectedAmount) {
                ForEach(amountList, id: \.self) { amount in
                    Text(String(Int(amount)))
                }
            }
            .labelsHidden()
            NavigationLink(destination: ResultsView(amount: selectedAmount, baseCurrency: selectedCurrency)) {
                Text("Go")
            }
        }
    }
}

struct QuickConversion_Previews: PreviewProvider {
    static var previews: some View {
        QuickConversion()
    }
}
