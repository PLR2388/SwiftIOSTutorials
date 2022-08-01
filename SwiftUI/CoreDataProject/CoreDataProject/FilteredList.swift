//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Paul-Louis Renard on 01/08/2022.
//

import SwiftUI

struct FilteredList: View {
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init(filter: String) {
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: <#T##NSPredicate?#>)
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList()
    }
}
