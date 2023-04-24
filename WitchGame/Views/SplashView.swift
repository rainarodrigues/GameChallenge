//
//  SplashView.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 02/04/23.
//

import SwiftUI
import Lottie

struct SplashView: View {
    @State var isActive: Bool = false
    let animationWitchView = LottieAnimationView()

    @State var rotation = 0.0
    @State var scaleXY = 1.0
    @State var positionX = -150

    var body: some View {
        ZStack() {
            if self.isActive {
                MenuGameView()
            } else {
                LottieBackground(lottieName: "starsbg")
                    .ignoresSafeArea(.all)
                ZStack {
                    Image("WitchFlyingStatic")
                        .resizable()
                        .frame(width: 220, height: 219.15)
// Podemos ter um efeito de cambalhota se descomentarmos a linha seguinte
//                        .rotationEffect(.degrees(rotation))
//                        .scaleEffect(CGFloat(scaleXY))
                        .offset(x: CGFloat(positionX))
                        .animation(Animation.easeInOut(duration: 1).speed(0.5), value: rotation)
//                    LottieBackground(lottieName: "witch-animation")
//                        .frame(width: 350, height: 350)
                        .onAppear() {
                            rotation += 360
                            scaleXY += 1.1
                            positionX += 350
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
