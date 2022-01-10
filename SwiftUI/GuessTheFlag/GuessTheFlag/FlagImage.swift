//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Paul-Louis Renard on 10/01/2022.
//

import SwiftUI

struct FlagImage: View {
    let flagName: String
    
    
    var body: some View {
        Image(flagName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(flagName: "France")
    }
}
