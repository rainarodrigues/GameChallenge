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
                    Text("Constelação \(details.id):  " + details.constellationName)
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                }, right: {
                    HStack {
                        Image("medal")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Recorde: \(details.record)")
                            .font(.custom("SF Pro Rounded", size: 17))
                            .foregroundColor(.yellow)
                            .fontWeight(.regular)
                            .padding(.trailing, 20)
                    }
                })
                .padding(.top, 25)

                HStack {
                    Image(details.constellationImage)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(20)
                        .padding(.leading, 60)
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
                        .padding(.trailing, 20)

                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

//struct ConstellationDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConstellationDetailsView(details: ConstellationDetailsModel())
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}

