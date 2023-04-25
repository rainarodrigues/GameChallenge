//
//  ConstellationDetailsView.swift
//  WitchGame
//
//  Created by Pedro Muniz on 20/04/23.
//

import SwiftUI
import Lottie

struct ConstellationDetailsView: View {
    
    let details: ConstellationDetailsModel
    
    var body: some View {
        ZStack{
            LottieBackground(lottieName: "starsbg")
            .ignoresSafeArea(.all)
            HStack {
                Image(details.constellationImage)
                    .resizable()
                    .frame(width: 250, height: 250)
                    .cornerRadius(20)
                VStack(spacing: 10) {
                    Text(details.constellationName)
                        .foregroundColor(.white)
                        .font(.title)
                    Text(details.constellationDetails)
                        .lineLimit(nil)
                        .foregroundColor(.white)
                    
                }.padding()
                    .background(.purple.opacity(0.1))
                    .cornerRadius(18)
                
            }
        }
    }
}

    

