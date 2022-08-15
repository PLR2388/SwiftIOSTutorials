//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Paul-Louis Renard on 01/08/2022.
//

import CoreData
import SwiftUI

enum Predicate {
    case beginsWith
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, predicate: Predicate, sortDescriptors: [SortDescriptor<T>], @ViewBuilder content: @escaping (T) -> Content) {
        let predicated: String
        
        switch predicate {
        case .beginsWith:
            predicated = "BEGINSWITH"
        }
        
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicated) %@", filterKey, filterValue))
        self.content = content
    }
}
