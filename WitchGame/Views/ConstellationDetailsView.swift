//
//  ConstellationDetailsView.swift
//  WitchGame
//
//  Created by Pedro Muniz on 20/04/23.
//

import SwiftUI
import Lottie

struct ConstellationDetailsView: View {

    let constellationName: String // c 1
//    let constellationName: String
//    let constellationImage: String
//    let animalImage: String
//    let constellationDetails: String
//    let position: String
//    let season: String
//    let trivia: String
//    let record: Int

    var body: some View {

        VStack {
            Text(constellationName)
        }
    }
}

struct ConstellationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ConstellationDetailsView(constellationName: "Orion")
            .previewInterfaceOrientation(.landscapeRight)
    }
}
