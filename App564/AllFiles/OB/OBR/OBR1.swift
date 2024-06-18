//
//  OBR1.swift
//  App564
//
//  Created by DJUROM on 03/06/2024.
//

import SwiftUI

struct OBR1: View {
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                Image("OBR1")
                    .resizable()
                    .ignoresSafeArea()
                
            }
            
            VStack {
                
                Text("The ability to edit and delete entries")
                    .foregroundColor(.black)
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                NavigationLink(destination: {
                    
                    OBR2()
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
    }
}

#Preview {
    OBR1()
}
