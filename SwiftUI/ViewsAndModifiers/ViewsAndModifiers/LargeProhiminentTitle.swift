//
//  LargeProhiminentTitle.swift
//  ViewsAndModifiers
//
//  Created by Paul-Louis Renard on 10/01/2022.
//

import SwiftUI

struct LargeProhiminentTitle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func toLargeTitle() -> some View {
        self.modifier(LargeProhiminentTitle())
    }
}



