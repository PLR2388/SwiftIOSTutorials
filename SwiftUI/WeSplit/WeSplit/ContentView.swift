//
//  ContentView.swift
//  WeSplit
//
//  Created by Paul-Louis Renard on 04/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    private var total: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    @FocusState private var amountIsFocused: Bool
    let currencyFormatter: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = total / peopleCount
        return amountPerPerson
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                                currencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
//                    Picker("Tip percentage", selection: $tipPercentage) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
//                    }
//                    .pickerStyle(.segmented)
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< 101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(total, format: currencyFormatter)
                        .foregroundColor(tipPercentage == 0 ? .red : .clear)
                } header: {
                    Text("Total amount")
                        .foregroundColor(tipPercentage == 0 ? .red : .clear)
                }
                
                Section {
                    Text(totalPerPerson, format: currencyFormatter)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
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
