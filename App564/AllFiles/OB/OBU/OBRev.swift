//
//  OBRev.swift
//  App564
//
//  Created by DJUROM on 03/06/2024.
//

import SwiftUI
import StoreKit

struct OBRev: View {
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                Image("OBRev")
                    .resizable()
                    .ignoresSafeArea()
                
            }
            
            VStack {
                
                Text("Rate our app in the AppStore")
                    .foregroundColor(.black)
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                NavigationLink(destination: {
                    
                    OBNot()
                        .navigationBarBackButtonHidden()
                    
                }, label: {
                    
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding()
                })
            }
        }
        .onAppear{
            
            SKStoreReviewController.requestReview()
        }
    }
}

#Preview {
    OBRev()
}
