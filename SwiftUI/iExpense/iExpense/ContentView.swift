//
//  ContentView.swift
//  iExpense
//
//  Created by Paul-Louis Renard on 13/03/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                let personal = expenses.items.filter {
                    $0.type == "Personal"
                }
                let business = expenses.items.filter {
                    $0.type == "Business"
                }
                Section {
                    ForEach(personal) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            if item.amount < 10 {
                                Text(item.amount, format: .currency(code: "USD"))
                            } else if item.amount < 100 {
                                Text(item.amount, format: .currency(code: "USD"))
                                    .font(.title2)
                            } else {
                                Text(item.amount, format: .currency(code: "USD"))
                                    .font(.headline)
                            }
                         
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }
                Section {
                    ForEach(business) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            if item.amount < 10 {
                                Text(item.amount, format: .currency(code: "USD"))
                            } else if item.amount < 100 {
                                Text(item.amount, format: .currency(code: "USD"))
                                    .font(.title2)
                            } else {
                                Text(item.amount, format: .currency(code: "USD"))
                                    .font(.headline)
                            }
                         
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        let business = expenses.items.filter {
            $0.type == "Business"
        }
        let idsToDelete = offsets.map { business[$0].id }
        expenses.items.removeAll { idsToDelete.contains($0.id)}
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        let personal = expenses.items.filter {
            $0.type == "Personal"
        }
        let idsToDelete = offsets.map { personal[$0].id }
        expenses.items.removeAll { idsToDelete.contains($0.id)}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
