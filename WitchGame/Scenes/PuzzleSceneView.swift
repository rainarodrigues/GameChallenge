//
//  PuzzleSixView.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 02/04/23.
//

import SwiftUI
import SpriteKit

struct PuzzleSceneView: View {
    @State private var gameStarted = false
    // teste
    var body: some View {
        GeometryReader { geo in
            LottieBackground(lottieName: "starsbg")
                .ignoresSafeArea(.all)
            ZStack {
                SpriteView(
                    scene: PuzzleScene(
                        size: CGSize(
                            width: geo.size.height,
                            height: geo.size.height
                        )
                    )
                )
                .frame(width: geo.size.width, height: geo.size.height + 20)
                // .padding(.top, 20)
                .disabled(!gameStarted) // Disable SpriteView when game is not started
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            ZStack{}
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct PuzzleSixView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleSceneView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
