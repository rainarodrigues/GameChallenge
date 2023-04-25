//
//  CharacterView.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 01/04/23.
//

import SwiftUI
import Lottie

struct CharacterView: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        ZStack(alignment: .top) {

            LottieBackground(lottieName: "starsbg")
                .ignoresSafeArea(.all)

                .navigationBarHidden(true)
            
            VStack {
                CustomNavBar(left: {
                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Image("navButtonBackground")
                                .resizable()
                                .frame(width: 139, height: 42)
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .font(.custom("SF Pro Rounded", size: 15))
                                    .foregroundColor(.purple)
                                    .fontWeight(.regular)
                                Text("Menu")
                                    .font(.custom("SF Pro Rounded", size: 15))
                                    .foregroundColor(.purple)
                                    .fontWeight(.regular)
                            }
                        }
                    }
                }, center: {
                    Text("Minhas conquistas")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                }, right: {
                    // Nothing goes on the right side of the NavBar on this View
                })
                .padding(.top, 25)

                HStack {

                    Image("Witch-Body 1")
                        .resizable()
                        .frame(width: 250, height: 287.56)
                        .scaledToFit()
                        .shadow(color: Color.purple, radius: 0.5)

                    HStack {

                        VStack {

                            Text("Prêmio 1: Maracá")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Image("award1")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .cornerRadius(20)
                            Button {
                                // code
                            } label: {
                                HStack {
                                    Image(systemName: "wand.and.stars")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                    Text("Equipar")
                                        .font(.custom("SF Pro Rounded", size: 16))
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                            }
                            .buttonStyle(.bordered)
                            .background(.indigo)
                            .cornerRadius(10)
                        }

                        VStack(alignment: .center) {
                            Text("Prêmio 2: Flauta Siku")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                            Image("award2")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .cornerRadius(20)
                                .padding(.leading, 20)
                            Button {
                                // code
                            } label: {
                                HStack {
                                    Image(systemName: "wand.and.stars")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                    Text("Equipar")
                                        .font(.custom("SF Pro Rounded", size: 16))
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                            }
                            .buttonStyle(.bordered)
                            .background(.gray)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(.white.opacity(0.1))
                    .cornerRadius(18)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

struct LottieBackground: UIViewRepresentable {
    typealias UIViewType = UIView
    let animationView = LottieAnimationView()
    var lottieName: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieBackground>) -> UIView {
        let view = UIView(frame: .zero)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieBackground>) {
        animationView.animation = LottieAnimation.named(lottieName)
        animationView.play()
    }
}


struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}




