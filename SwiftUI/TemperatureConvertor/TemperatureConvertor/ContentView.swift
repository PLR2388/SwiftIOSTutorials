//
//  ContentView.swift
//  TemperatureConvertor
//
//  Created by Paul-Louis Renard on 04/01/2022.
//

import SwiftUI

enum TemperatureUnit: String {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
}

struct ContentView: View {
    @State private var temperature: Double = 0
    @State private var selectedInitTemperature = TemperatureUnit.celsius
    @State private var selectedFinalTemperature = TemperatureUnit.celsius
    
    private var convertedTemperature: Double {
        if selectedInitTemperature == selectedFinalTemperature {
            return temperature
        }
        let kelvin: Double
        
        switch selectedInitTemperature {
        case .kelvin:
            kelvin = temperature
        case .celsius:
            kelvin = temperature - 273.15
        case .fahrenheit:
            kelvin = (temperature - 32) * 1.8 + 273.15
        }
        
        switch selectedFinalTemperature {
        case .fahrenheit:
            return (kelvin - 273.15) * 1.8 + 32
        case .kelvin:
            return kelvin
        case .celsius:
            return kelvin - 273.15
        }
    }
    
    let temperatureUnit: [TemperatureUnit] = [.celsius, .fahrenheit, .kelvin]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Initial Temperature", value: $temperature, format: .number)
                    Picker("Unit init temperature", selection: $selectedInitTemperature) {
                        ForEach(temperatureUnit, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Initial temperature")
                }
                
                Section {
                    Picker("Unit final temperature", selection: $selectedFinalTemperature) {
                        ForEach(temperatureUnit, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Converted Temperature")
                }
                
                Section {
                    Text(convertedTemperature, format: .number)
                }
            }
            .navigationTitle("Temperature Convertor")
            .navigationBarTitleDisplayMode(.inline)
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
