//
//  ContentView.swift
//  GameChallenge
//
//  Created by Raina Rodrigues de Lima on 29/03/23.
//

import SwiftUI

struct ContentView: View {
    
    private let countDownView = CountDownView()
    var body: some View {
        VStack {
            countDownView
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


