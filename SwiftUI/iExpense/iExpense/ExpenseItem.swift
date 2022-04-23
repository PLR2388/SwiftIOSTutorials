//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Paul-Louis Renard on 27/03/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
