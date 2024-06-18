//
//  LoadingView.swift
//  App564
//
//  Created by DJUROM on 03/06/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                Image("firstLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 280)
            }
            
            
            VStack {
                
                Spacer()
                
                ProgressView()
                    .padding()
            }
        }
    }
}

#Preview {
    LoadingView()
}
