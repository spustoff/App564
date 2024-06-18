//
//  GamesView.swift
//  App564
//
//  Created by DJUROM on 03/06/2024.
//

import SwiftUI

struct GamesView: View {
    
    @StateObject var viewModel = GamesViewModel()
    
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = true
                    }
                    
                }, label: {
                    
                   Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text("Your games")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if viewModel.games.isEmpty {
                    
                    VStack {
                        
                        Text("Create your first game")
                            .foregroundColor(.black)
                            .font(.system(size: 26, weight: .bold))
                        
                        Image("stick")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = true
                            }
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                                .padding()
                        })
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    
                    Spacer()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack(spacing: 12) {
                            
                            ForEach(viewModel.games, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.selectedGame = index
                                    viewModel.currentGame = viewModel.selectedGame?.gName ?? ""
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDetail = true
                                        
                                    }
                                    
                                }, label: {
                                    
                                    VStack(alignment: .leading, spacing: 14) {
                                        
                                        Text(index.gName ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, weight: .semibold))
                                            .padding(.top)
                                        
                                        Spacer()
                                        
                                        Text(index.gDescription ?? "")
                                            .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .medium))

                                        Text(index.gRules ?? "")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 15, weight: .regular))
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: 150)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                                })
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchGames()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddGame(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            GameDetail(viewModel: viewModel)
        })
    }
}

#Preview {
    GamesView()
}
