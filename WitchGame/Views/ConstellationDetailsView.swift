//
//  ConstellationDetailsView.swift
//  WitchGame
//
//  Created by Pedro Muniz on 20/04/23.
//

import SwiftUI
import Lottie

struct ConstellationDetailsView: View {

    @Environment(\.dismiss) var dismiss
    
    let details: ConstellationDetailsModel
    
    var body: some View {
        ZStack{

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
//                                .padding(.leading, 15)
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .font(.custom("SF Pro Rounded", size: 15))
                                    .foregroundColor(.purple)
                                    .fontWeight(.regular)
//                                    .padding(.top, -5)
                                Text("Menu")
                                    .font(.custom("SF Pro Rounded", size: 15))
                                    .foregroundColor(.purple)
                                    .fontWeight(.regular)
//                                    .padding(.top, -5)
    //                                .padding(.leading, 15)
                            }
                        }
                    }
                }, center: {
                    Text("Constelação \(details.id):  " + details.constellationName)
                        .foregroundColor(.white)
                        .font(.custom("SF Pro Rounded", size: 28))
                        .fontWeight(.heavy) // Why doesn't this do anything?
                }, right: {
                    HStack {
                        Image("medal")
                            .resizable()
                            .frame(width: 50, height: 50)
//                            .padding(.trailing, 15)
                        Text("Recorde: \(details.record)")
                            .font(.custom("SF Pro Rounded", size: 17))
                            .foregroundColor(.yellow)
                            .fontWeight(.regular)

                    }
                })
                HStack {
                    Image(details.constellationImage)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(20)
                    VStack(spacing: 10) {
                        Text(details.constellationDetails)
                            .font(.custom("SF Pro Rounded", size: 17))
                            .lineLimit(nil)
                            .foregroundColor(.white)
                        Text(details.season)
                            .font(.custom("SF Pro Rounded", size: 17))
                            .lineLimit(nil)
                            .foregroundColor(.white)

                    }.padding()
                        .background(.purple.opacity(0.1))
                        .cornerRadius(18)

                }
            }
        }.ignoresSafeArea(.all)
    }
}

//struct ConstellationDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConstellationDetailsView(details: constellationDetailsModel)
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}

