//
//  ContentView.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 31/03/23.
//

import SwiftUI
import Combine

struct MenuGameView: View {
    
    let buttonSize: CGFloat = 30
    
    @State var isPlaying = false
    @State var isBlocked = false
    
    @State var volume: Float = 1.0
    @State var showSlider = false
    @State private var isShowingSlider = false
    let userDefaults = UserDefaults.standard
    let isPlayingKey = "isPlayingKey"
    let isBlockedKey = "isBlockedKey"

    let isLocked: Bool
    let isLocked2: [Bool] = [false, true, true, true]
    @GestureState private var isPressing = false

    // Respect 266 characters maximum for the constellationDetails:
    @State var constellationDetailsModel: [ConstellationDetailsModel] = [
        ConstellationDetailsModel(
            id: 1,
            constellationName: "A Ema",
            constellationImage: "Constellation1Reveal",
            animalImage: "Constellation1Puzzle",
            constellationDetails: "Esta constelação retrata uma Ema capaz de devorar estrelas. Duas estrelas da constelação da Mosca representam o bico da ave, que está tentando comer dois ovos. Duas outras estrelas da constelação de Centauro simbolizam ovos que a Ema acabou de engolir. O Cruzeiro do Sul está acima de sua cabeça, e representa uma forquilha que impede a Ema de beber as águas do mundo. As manchas da Via Láctea representam sua plumagem.",
            position: "Limitada pelas constelações de Escorpião, por um lado, e o Cruzeiro do Sul, por outro.",
            season: "Surge no inverno, na segunda quinzena de junho, do lado leste do céu.",
            trivia: "Quando Claude D'Abbeville entrevistou os Tupinambá no Maranhão em 1612, ele batizou a constelação de Avestruz Americana. Mas já que não havia avestruz no Brasil, ela passou a ser chamada de Ema.",
            record: 1,
            isBlocked: false
        ),
        ConstellationDetailsModel(
            id: 2,
            constellationName: "A Anta",
            constellationImage: "Constellation2Reveal",
            animalImage: "Constellation1Puzzle",
            constellationDetails: "Nesta constelação, a Anta caminha pela Via Láctea, que é considerada o Caminho das Antas pelos povos originários do Brasil. Ela é mais conhecida entre os indígenas do norte, uma vez que na região sul a Anta aparece muito próxima da linha do horizonte, o que dificulta sua identificação. Assim, os povos do sul utilizam a constelação do Colibri para indicar a chegada da primavera.",
            position: "Limitada pelas constelações ocidentais de Cisne e da Cassiopéia.",
            season: "Aparece na primavera, na segunda quinzena de setembro, no lado leste do céu.",
            trivia: "Para os índios do norte do Brasil, indica uma estação de transição entre a seca e a chuva. Já para os índios do sul, indica uma estação de transição entre o frio e o calor.",
            record: 1,
            isBlocked: true
        ),
        ConstellationDetailsModel(
            id: 3,
            constellationName: "O Cervo",
            constellationImage: "Constellation3Reveal",
            animalImage: "Constellation1Puzzle",
            constellationDetails: "A constelação do Cervo ou Veado é conhecida principalmente pelas etnias de índios brasileiros da região sul do país, já que, para os povos do norte, ela fica muito próxima da linha do horizonte. Como ela está localizada inteiramente dentro da Via Láctea, o caminho das Antas, também é conhecida como Anta do Norte (há outras constelações com o nome 'Anta' na astronomia Tupi-Guarani.",
            position: "Limitada pelas constelações ocidentais Vela e Cruzeiro do Sul.",
            season: "Surge no outono, na segunda quinzena de março, no lado leste do céu.",
            trivia: "O Cervo indica uma estação de transição entre o calor e o frio para os índios do sul do Brasil. Já para os índios do norte do Brasil, indica a transição entre a chuva e a seca.",
            record: 1,
            isBlocked: true
        ),
        ConstellationDetailsModel(
            id: 4,
            constellationName: "O Homem Velho",
            constellationImage: "Constellation4Reveal",
            animalImage: "Constellation1Puzzle",
            constellationDetails: "A constelação do Homem Velho representa um homem cuja esposa passou a se interessar pelo seu irmão mais novo. Para ficar com o cunhado, a esposa tentou matar o marido, cortando-lhe a perna. Então os deuses ficaram com pena do marido e o transformaram em constelação.",
            position: "Limitada pelas constelações ocidentais de Touro e Órion.",
            season: "Aparece no Verão. Surge na segunda quinzena de dezembro, no lado leste.",
            trivia: "Indica o início do verão para os índios do sul do Brasil e o início da estação chuvosa para os índios do norte do Brasil. É composta por outras constelações indígenas: Eixu (as Pleiades), Tapi'i rainhyakã (as Hyades, incluindo Aldebaran) e Joykexo (O Cinturão de Orion).",
            record: 1,
            isBlocked: true
        )
    ]

    func constellationDetailsViewButton(model: ConstellationDetailsModel) -> some View {
        NavigationLink(destination: ConstellationDetailsView(details: model)) {
            HStack {
                Image(systemName: "info.bubble.fill")
                    .font(.system(size: 16))
                Text("Detalhes")
                    .font(.custom("SF Pro Rounded", size: 16))
                    .fontWeight(.semibold)
            }.frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .foregroundColor(.white)
        .tint(.purple)
    }

    func puzzleViewButton(model: ConstellationDetailsModel) -> some View {
        NavigationLink(destination: PuzzleView()) {
            VStack(spacing: 5) {
                Text("\(model.id). \(model.constellationName)")
                    .font(.custom("SF Pro Rounded", size: 17))
                    .foregroundColor(.white)
                Image(model.constellationImage)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .cornerRadius(25)
                    .overlay(Image(model.isBlocked ? "lock" : "start")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .opacity(isPressing ? 0 : 1)
                    )
            }.frame(maxWidth: .infinity)
        }
        .disabled(model.isBlocked)
//        .simultaneousGesture(
//            LongPressGesture(minimumDuration: 1)
//                .updating($isPressing) { value, state, transaction in
//                    state = value
//                }
//        )
        .buttonStyle(.plain)
        
    }

    var body: some View {
        
        NavigationView {
            ZStack {
                LottieBackground(lottieName: "starsbg")
                    .ignoresSafeArea(.all)

                VStack() {
                    CustomNavBar(left: {
                        NavigationLink(destination: CharacterView()) {
                            VStack {
                                Image("WitchHead 1")
                                    .resizable()
                                    .frame(width: 80, height: 80)
//                                    .border(Color.red)
                                    .padding(.leading, 15)
                                Text("Mais sobre mim")
                                    .font(.custom("SF Pro Rounded", size: 11))
                                    .foregroundColor(.white)
                                    .fontWeight(.regular)
                                    .padding(.top, -5)
                                    .padding(.leading, 15)
                            }
                        }
                    }, center: {
                        Image("AppTitleProvisory2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 106)
                    }, right: {
                        Button(action: {
                            if self.isPlaying {
                                stopAudioLooping()
                                isPlaying = false
                            } else {
                                playAudioLooping(filename: "music", fileExtension: "mp3")
                                isPlaying = true
                            }
                            userDefaults.set(isPlaying, forKey: isPlayingKey)
                        }, label: {
                            VStack {
                                Image(systemName: self.isPlaying ? "speaker.fill" : "speaker.slash.fill")
                                    .foregroundColor(.white)
                                    .opacity(0.8)
                                    .font(.system(size: 50))
                                    .padding(.bottom, 10)
                                Text(self.isPlaying ? "Áudio On" : "Áudio Off")
                                    .font(.custom("SF Pro Rounded", size: 11))
                                    .foregroundColor(.white)
                                    .fontWeight(.regular)
                                    .padding(.top, -10)
                            }
                        })
                        .buttonStyle(.plain)
                        .onAppear(perform: {
                            if let savedIsPlaying = userDefaults.value(forKey: isPlayingKey) as? Bool {
                                isPlaying = savedIsPlaying
                                if isPlaying {
                                    playAudioLooping(filename: "music", fileExtension: "mp3")
                                }
                            }
                        })
                    })
                    
                    .padding(.top, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 40) {
                            ForEach(constellationDetailsModel, id: \.id) { model in
                                VStack{
                                    puzzleViewButton(model: model)
                                    constellationDetailsViewButton(model: model)
                                }
                            }
//                            ForEach(1...4, id: \.self) { index in
//                                PuzzleButtonView(title: "Constelação \(index)", imageName: "Constellation1Puzzle", isLocked: index != 1, constelationName: "Fase \(index)")
//                                    .font(.custom("SF Pro Rounded", size: 21))

                        }
                        .padding(.leading, 20)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MenuGameView(isLocked: true)
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}

struct CustomNavBar<Left, Center, Right>: View where Left: View, Center: View, Right: View {
    let left: () -> Left
    let center: () -> Center
    let right: () -> Right
    init(@ViewBuilder left: @escaping () -> Left, @ViewBuilder center: @escaping () -> Center, @ViewBuilder right: @escaping () -> Right) {
        self.left = left
        self.center = center
        self.right = right
    }
    var body: some View {
        ZStack {
            HStack {
                left()
                Spacer()
            }
            center()
            HStack {
                Spacer()
                right()
            }
        }
    }
}

//struct PuzzleButtonView: View {
//    let title: String
//    let imageName: String
//    let isLocked: Bool
//
//    let constelationName: String // c 1
//
//    @GestureState private var isPressing = false
//
//    var body: some View {
//        VStack(spacing: 10) {
//            Text(title)
//                .foregroundColor(.white)
//
//            NavigationLink(destination: PuzzleSceneView()) {
//                Image(imageName)
//                    .renderingMode(.original)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 150, height: 150)
//                    .cornerRadius(25)
//                    .overlay(
//                        Image(isLocked ? "lock" : "star")
//                            .resizable()
//                            .frame(width: 75, height: 75)
//                            .opacity(isPressing ? 0 : 1)
//                    )
//            }
//            .disabled(isLocked)
//            .simultaneousGesture(
//                LongPressGesture(minimumDuration: 1)
//                    .updating($isPressing) { value, state, transaction in
//                        state = value
//                    }
//            )
//            .buttonStyle(.plain)
//
//            NavigationLink(destination: ConstellationDetailsView(constellationName: constelationName)) {
//                HStack {
//                    Image(systemName: "info.bubble.fill")
//                        .font(.system(size: 16))
//                    Text("Detalhes")
//                        .font(.custom("SF Pro Rounded", size: 16))
//                        .fontWeight(.semibold)
//                }.frame(maxWidth: .infinity)
//            }
//            .buttonStyle(.bordered)
//            .foregroundColor(.white)
//            .tint(.purple)
//        }
//    }
//}

struct SliderView: View {
    @Binding var volume: Float
    @Binding var isShowingSlider: Bool
    var body: some View {
        VStack {
            Slider(value: $volume, in: 0...1, onEditingChanged: { _ in
                updateVolume(volume: volume)
            })
            .accentColor(.purple)
            .padding()
            
            Button(action: {
                isShowingSlider = false
            }, label: {
                Text("Done")
            })
            .padding()
        }
        .navigationTitle("Volume")
    }
}
