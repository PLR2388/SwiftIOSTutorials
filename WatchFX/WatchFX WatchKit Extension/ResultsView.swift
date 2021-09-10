//
//  ResultsView.swift
//  WatchFX WatchKit Extension
//
//  Created by Paul-Louis Renard on 10/09/2021.
//

import SwiftUI
import Combine

enum FetchState {
    case fetching, success, failed
}

struct CurrencyResult: Codable {
    let base: String
    let rates: [String: Double]
}

struct ResultsView: View {
    let amount: Double
    let baseCurrency: String
    let appID = "e5f58214054441b2b48f0be9e3a3bccd"
    
    @State private var fetchState = FetchState.fetching
    @State private var fetchedCurrencies = [(symbol: String, rate: Double)]()
    @State private var request: AnyCancellable?
    
    var body: some View {
        // Add view in group just to have a navigation title
        Group {
            if fetchState == .success {
                List {
                    ForEach(fetchedCurrencies, id: \.symbol) { currency in
                        Text(rate(for: currency))
                    }
                }
            } else {
                Text(fetchState == .fetching ? "Fetching..." : "Fetch failed")
            }
        }
        .navigationTitle("\(Int(amount)) \(baseCurrency)")
        .onAppear(perform: fetchData)
    }
    
    func parse(result: CurrencyResult) {
        if result.rates.isEmpty {
            // fetch error!
            fetchState = .failed
        } else {
            // fetch succeeded!
            fetchState = .success
            
            // read the user's selected currencies
            let selectedCurrencies = UserDefaults.standard.array(forKey: ContentView.selectedCurrenciesKey) as? [String] ?? ContentView.defaultCurrencies
            
            for symbol in result.rates {
                // filter th rates so we only show ones the user cares about
                guard selectedCurrencies.contains(symbol.key) else { continue}
                let rateName = symbol.key
                let rateValue = symbol.value
                fetchedCurrencies.append((symbol: rateName, rate: rateValue))
            }
            
            fetchedCurrencies.sort {
                $0.symbol < $1.symbol
            }
        }
    }
    
    func rate(for currency: (symbol: String, rate: Double)) -> String {
        let value = currency.rate * amount
        let rate = String(format: "%.2f", value)
        return "\(currency.symbol) \(rate)"
    }
    
    func saveAmountAndBaseCurrency() {
        UserDefaults.standard.set(amount, forKey: ContentView.previousAmountKey)
        UserDefaults.standard.set(baseCurrency, forKey: ContentView.previousBaseCurrencyKey)
    }
    
    func fetchData() {
        saveAmountAndBaseCurrency()
        if let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=\(appID)") {
            request = URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: CurrencyResult.self, decoder: JSONDecoder())
                .replaceError(with: CurrencyResult(base: "", rates: [:]))
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: parse)
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(amount: 500, baseCurrency: "USD")
    }
}
