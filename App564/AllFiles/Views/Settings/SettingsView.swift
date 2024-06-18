//
//  SettingsView.swift
//  App564
//
//  Created by DJUROM on 03/06/2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Button(action: {
                    
                    
                    
                }, label: {
                    
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .opacity(0)
                
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {
                        
                        Button(action: {
                            
                            SKStoreReviewController.requestReview()

                        }, label: {
                            
                            VStack(spacing: 13) {
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(.black)
                                    .font(.system(size: 18, weight: .regular))
                                
                                Text("Rate Us")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .padding()
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        })
                        
                        Button(action: {

                            guard let url = URL(string: DataManager().usagePolicy) else { return }
                            
                            UIApplication.shared.open(url)
                            
                        }, label: {
                            
                            VStack(spacing: 13) {
                                
                                Image(systemName: "doc.text.fill")
                                    .foregroundColor(.black)
                                    .font(.system(size: 18, weight: .regular))
                                
                                Text("Usage Policy")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .padding()
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        })
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
