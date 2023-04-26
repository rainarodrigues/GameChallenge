//
//  PuzzleView.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 01/04/23.
//

import SwiftUI
import SpriteKit

struct PuzzleView: View {
    
    
    var body: some View {
        ZStack() {
           Color(red: 0.25882, green: 0.15294, blue: 0.44314)
                .ignoresSafeArea(.all)
            GeometryReader { geo in
                ZStack {
                    SpriteView(scene: PuzzleScene(size: CGSize(width: geo.size.height, height: geo.size.height)))
                        .frame(width: geo.size.width, height: geo.size.height)
                    
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
