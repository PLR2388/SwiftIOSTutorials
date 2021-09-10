//
//  ContentView.swift
//  WatchFX WatchKit Extension
//
//  Created by Paul-Louis Renard on 10/09/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount = UserDefaults.standard.double(forKey: previousAmountKey) ?? 500.0
    @State private var selectedCurrency = UserDefaults.standard.string(forKey: previousBaseCurrencyKey) ?? "USD"
    @State private var amountFocused = false
    
    static let currencies = ["USD", "AUD", "CAD", "CHF", "CNY", "EUR", "GBP", "HKD", "JPY", "SGD"]
    static let selectedCurrenciesKey = "SelectedCurrencies"
    static let defaultCurrencies = ["USD", "EUR" ]
    static let previousAmountKey = "previousAmount"
    static let previousBaseCurrencyKey = "previousBaseCurrencyKey"
    
    var body: some View {
        GeometryReader { geo in // Use to position correctly views
            VStack(spacing: 0) {
                Text("\(Int(amount))")
                    .font(.system(size: 52))
                    .padding()
                    .frame(width: geo.size.width)
                    .contentShape(Rectangle()) // increment touch area
                    .focusable { amountFocused = $0 } // Need it to enable digital crown
                    .digitalCrownRotation($amount, from: 0, through: 1000, by: 20, sensitivity: .high, isContinuous: false, isHapticFeedbackEnabled: true) // Similar work to Slider but with digitalCrown
                // isContinuous means we go back to 0 after 1000
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(amountFocused ? Color.green : Color.white, lineWidth: 1)
                    )
                    .padding(.bottom)
                HStack {
                    Picker("Select a currency", selection: $selectedCurrency) {
                        ForEach(Self.currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                    .labelsHidden()
                    
                    NavigationLink(destination: ResultsView(amount: amount, baseCurrency: selectedCurrency)) {
                        Text("Go")
                    }
                    .frame(width: geo.size.width * 0.4) // Make Go button takes 40% of the width screen
                }
                .padding()
                .frame(width: geo.size.width)
             
            }
            .navigationTitle("WatchFX")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
