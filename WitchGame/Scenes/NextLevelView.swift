//
//  NextLevelView.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 27/04/23.
//

import Foundation
import SwiftUI

struct NextLevelView: View {
    @Binding var showCongratulation: Bool
    
    var body: some View {
        VStack {
            Text("Congratulations!")
                .font(.title)
                .padding()
            Text("You have completed the puzzle!")
                .padding()
            Button("Next Level") {
                showCongratulation = false
                // Do something when the Next Level button is tapped
            }
            .padding()
        }
        .background(Color.white)
        .frame(width: 300, height: 200)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
