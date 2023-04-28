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
    
    @State var animatedValue = 1.0
    
    @State var rotation = 0.0
    @State var scaleXY = 1.0
    @State var positionX = -150
    
    var body: some View {
        
        NavigationView {
            NavigationLink(destination: MenuGameView(isLocked: false).navigationBarBackButtonHidden()) {
                
                ZStack() {
                    if self.isActive {
                        MenuGameView(isLocked: false)
                    } else {
                        LottieBackground(lottieName: "starsbg")
                            .ignoresSafeArea(.all)
                        HStack {
                            VStack {
                                Image("AppTitleProvisory2")
                                    .resizable()
                                    .scaledToFill()
                                //                            .scaleEffect(animatedValue)
                                    .frame(width: 180.0, height:100.0)
                                    .position(x: 310, y: 200)
                                    .opacity(0.50 * animatedValue)
                                    .animation(.easeOut.delay(1.5), value: animatedValue)
                                
                                Image("WitchFlyingStatic")
                                    .resizable()
                                    .frame(width: 230, height: 229.15)
                                    .offset(x: CGFloat(positionX))
                                    .position(x: 75)
                                    .animation(Animation.easeInOut(duration: 1).speed(0.5), value: rotation)
                                    .onAppear() {
                                        rotation += 360
                                        scaleXY += 1.1
                                        positionX += 675
                                    }
                                
                            } .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }     .onAppear() {
                            animatedValue += 1
                        }
                        
                        //            struct SplashView_Previews: PreviewProvider {
                        //                static var previews: some View {
                        //                    SplashView()
                        //                        .previewInterfaceOrientation(.landscapeRight)
                        //                }
                        //            }
                    }
                }
            }
        }
        
    }
}
