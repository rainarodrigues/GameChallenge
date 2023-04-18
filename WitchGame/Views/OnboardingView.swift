//
//  OnboardingView.swift
//  WitchGame
//
//  Created by Pedro Muniz on 15/04/23.
//

import SwiftUI

// O que eu gostaria de fazer nesta tela:
// 1. Fazer aparecer e depois desaparecer (com efeito 'fading in & out') imagens por cima do frame da imagem de fundo, em diferentes posições - imagens das constelações e, no final, a bruxinha voando da esquerda para a direita;
// 2. Fazer aparecer e depois desaparecer os textos no frame inferior, em ordem;
// Opcional: dar ao usuário a possibilidade de passar o texto, voltar para o texto anterior ou pausar clicando na tela, como fazemos em stories no Instagram. Na sequência desta tela, vem o menu do jogo.
// Opcional 2: Fazer o texto aparecer em estilo "máquina de escrever", progressivamente, uma letra por vez.

let onBoardingText1 = "Desde muito tempo, vários povos ao redor do mundo olharam para o céu noturno e identificaram conjuntos de estrelas que hoje chamamos de constelações..."
let onBoardingText2 = "...Cada constelação é representada por um símbolo, um animal ou um ser mitológico importante, e guarda também uma história mágica que vamos lhe contar!"
let onBoardingText3 = "Ajude a bruxa Celeste a descobrir as constelações dos povos originários da América do Sul e assim obter novos poderes mágicos!"

let onBoardingWitch = Image("WitchFlyingStatic")

let onBoardingImagesNames = ["Const1Onboarding", "Const2Onboarding", "Const3Onboarding"]

let onBoardingTexts = [onBoardingText1, onBoardingText2, onBoardingText3]

struct OnboardingView: View {

    @State var isActive: Bool = false

    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
//    @State var opacity1 = 0.0
//    @State var opacity2 = 0.0
//    @State var opacity3 = 0.0

    var body: some View {

        ZStack {
            VStack{
                Image("OnBoardingBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 860.0, height:280.0, alignment: .top)
    //                .border(Color.red)
                    .clipShape(Rectangle())
                    .position(x: 370, y: 140)

                Text(onBoardingText1)
                    .font(.custom("SF Pro Rounded", size: 20))
                    .fontWeight(.regular)
                    .frame(width: 760.0, height: 100.0, alignment: .center)
    //                .border(Color.red)
                    .position(x: 370, y: 140)
    //                .background(.purple)
            }
            HStack {
                Image(onBoardingImagesNames[0])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220.0, height: 184.68, alignment: .top)
                    .position(x: 100, y: 100)
//                    .opacity(opacity1)
                    .onAppear()

                Image(onBoardingImagesNames[1])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220.0, height: 184.68, alignment: .top)
                    .position(x: 150, y: 200)
                    .transition(.scale)

                Image(onBoardingImagesNames[2])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220.0, height: 184.68, alignment: .top)
                    .position(x: 150, y: 120)
                    .transition(.scale)
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }

    }
    
}

//func typeWriter() {
//    //code
//}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
